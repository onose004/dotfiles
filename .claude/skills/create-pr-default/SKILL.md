---
name: create-pr-default
description: 現在のブランチから標準化されたプルリクエストを作成する
---

# プルリクエスト作成

現在のブランチから標準化されたプルリクエストを作成します。

## 実行内容

1. **現在のブランチが feature ブランチであることを確認**（main/develop でないこと）
2. **最新の origin 状態を取得**（`git fetch origin`）
3. 現在のブランチを分析してベースブランチを自動決定
4. **origin/[target] との差分を分析**して PR タイトルを自動生成
5. **実際のファイル変更を分析**して詳細な説明を生成
6. **`--draft` フラグを付けて Draft PR として作成する**

## ベースブランチ自動決定ロジック

- **feat/**, **feature/**: main にマージ（develop がある場合は develop）
- **fix/**, **hotfix/**: main にマージ
- **release/**: main にマージ
- **docs/**, **chore/**: main にマージ（develop がある場合は develop）
- その他: main にマージ

## 自動生成される PR 内容

### タイトル

- ファイル変更内容を分析して Conventional Commits 形式で生成
- `git diff origin/[target]..HEAD` から機能追加・修正・削除を判定
- 日本語で記載

### 説明

新規 PR 本文には**必ず以下のテンプレートをそのまま使用する**。見出し構造（順番・文言・`[Optional]` 表記を含む）は省略・改変しない。

```markdown
## What?

-

## Why?

-

## Screenshot or video [Optional]

特になし

## See also [Optional]

特になし
```

- `## What?` と `## Why?` は**必要最低限で簡潔に**書く。背景説明・実装詳細・テスト記録などは入れない。
- 追加で節を切る必要がある場合は、**`## What?` または `## Why?` の配下に `###` (H3) で**追加する。**トップレベルの新しい `##` 見出しは絶対に追加しない**（テンプレートの 4 セクション以外は増やさない）。
- `## See also [Optional]` には**チケット番号・参照 URL のみ**を箇条書きで列挙する。備考・補足・所感などのテキストは禁止。参照が無い場合は本文に `特になし` とだけ書く。
- `## Screenshot or video [Optional]` には UI 変更時のスクリーンショット・動画のみを貼る。該当しない場合は本文に `特になし` とだけ書く。
- HTML コメント `<!-- -->` はエスケープせずそのまま含める
- HEREDOC を使用する際はシングルクォートで囲む（`<<'EOF'`）
- Co-Authored-By 署名は入れない

## 技術的な実装原則

1. **必ず最初に `git fetch origin` を実行**
2. **`git diff origin/[target]..HEAD` で差分を取得**（ローカルブランチ参照禁止）
3. **コミット履歴でなくファイル差分をベースに説明生成**
4. リモートブランチが存在しない場合は自動プッシュ（`git push -u origin HEAD`）
5. **必ず `gh pr create --draft ...` で Draft PR として作成する**（通常 PR で作るのは禁止）
