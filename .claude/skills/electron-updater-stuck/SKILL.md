---
name: electron-updater-stuck
description: Diagnose and fix macOS Electron apps (Notion, VS Code, Slack, etc.) whose Squirrel auto-updater loops with "An update is ready to install / trying to add a new helper tool" dialogs. Trigger when the user reports a repeating update/helper-tool prompt for an Electron app on macOS.
---

# Electron app updater stuck on macOS (Squirrel loop)

## Symptom

A macOS dialog like the following appears every time the user launches an
Electron-based app (Notion, VS Code, Slack, Figma, Discord, ...):

> An update is ready to install. **&lt;App&gt;** is trying to add a new helper tool.

The dialog reappears no matter how many times the user clicks Install / Not Now.

## Root cause

Electron apps on macOS auto-update via Squirrel.Mac. Squirrel runs as the
user, downloads the new `.app` into `~/Library/Caches/<bundle-id>.ShipIt/`,
and then tries to swap it into `/Applications/<App>.app`. If `/Applications/<App>.app`
is owned by `root:wheel` (common after migration assistant, TimeMachine
restore, or an initial install via `sudo`), the swap fails. Squirrel marks
the pending update in `ShipItState.plist` and retries on every launch — hence
the loop.

The "helper tool" the dialog mentions is the privilege-escalation helper
Squirrel wants to install to do the swap with elevated rights.

## Diagnostic steps

Run these to confirm before recommending a fix:

1. **Find the ShipIt cache** (proof of stuck update):
   ```
   ls -la ~/Library/Caches/*.ShipIt/
   ```
   Look for `ShipItState.plist` plus an `update.XXXXXX/` directory, and
   multiple `ShipIt_stderr.log.N` files (each retry creates a new log) —
   that pattern confirms the loop.

2. **Check ownership of the app bundle** (the smoking gun):
   ```
   ls -lad /Applications/<App>.app
   ```
   If owner is `root` (not the current user), this is the cause.

3. **Optional — read a recent failure log** to be sure:
   ```
   cat ~/Library/Caches/<bundle>.ShipIt/ShipIt_stderr.log.<latest-N>
   ```
   Typical messages mention permission errors writing into `/Applications`.

## Fix

The user has a script at `~/dotfiles/bin/fix-electron-updater` that does the
following for each given app name:

1. Warn if the app is still running
2. `sudo chown -R "$(whoami):staff" /Applications/<App>.app`
3. Remove pending updates: `rm -rf ~/Library/Caches/<bundle>.ShipIt/update.* ~/Library/Caches/<bundle>.ShipIt/ShipItState.plist`

Usage:
```
fix-electron-updater Notion "Visual Studio Code"
fix-electron-updater --help
```

**Before running, ask the user to fully quit the target apps** (Cmd+Q,
including any menu-bar/tray instances). Then propose the command — the
script uses `sudo` so it will prompt for password.

## Notes / caveats

- Deleting `ShipItState.plist` and `update.*` is safe. The updater will
  re-download on next launch. User settings live under
  `~/Library/Application Support/<App>/` and are untouched.
- If ownership is already the user but the loop continues, the cause is
  different (e.g., quarantine xattr, codesigning failure, or an app
  installed under a different `/Applications` path like `~/Applications`).
  Read the latest `ShipIt_stderr.log.*` for the specific error before
  guessing further.
- To survey other root-owned apps that may hit this later:
  ```
  ls -la /Applications | awk '$3=="root"'
  ```
