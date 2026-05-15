#!/bin/bash

set -euo pipefail

# ------------------------------------------------------------------------------
# ghq

if ! command -v ghq &>/dev/null; then
  ARCH=$(uname -m)
  case $ARCH in
  x86_64) ARCH=amd64 ;;
  aarch64) ARCH=arm64 ;;
  esac
  GHQ_VERSION="1.6.2"
  curl -fsSL \
    "https://github.com/x-motemen/ghq/releases/download/v${GHQ_VERSION}/ghq_linux_${ARCH}.zip" \
    -o /tmp/ghq.zip
  unzip -o /tmp/ghq.zip -d /tmp/ghq
  install -m 755 "/tmp/ghq/ghq_linux_${ARCH}/ghq" /usr/local/bin/ghq
  rm -rf /tmp/ghq.zip /tmp/ghq
fi

# ------------------------------------------------------------------------------
# node (via n) — skip in CI

if [[ "${CI:-}" != "true" ]] && ! command -v node &>/dev/null; then
  if command -v apt-get &>/dev/null; then
    DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs npm
  elif command -v dnf &>/dev/null; then
    dnf install -y nodejs npm
  fi
  npm install -g n
  n stable
  if command -v apt-get &>/dev/null; then
    DEBIAN_FRONTEND=noninteractive apt-get purge -y nodejs npm
  elif command -v dnf &>/dev/null; then
    dnf remove -y nodejs npm
  fi
fi
