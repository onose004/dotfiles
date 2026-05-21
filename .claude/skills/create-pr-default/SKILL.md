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
- What? / Why? セクションで構成する
- HTML コメント `<!-- -->` はエスケープせずそのまま含める
- HEREDOC を使用する際はシングルクォートで囲む（`<<'EOF'`）
- Co-Authored-By 署名は入れない

## 技術的な実装原則
1. **必ず最初に `git fetch origin` を実行**
2. **`git diff origin/[target]..HEAD` で差分を取得**（ローカルブランチ参照禁止）
3. **コミット履歴でなくファイル差分をベースに説明生成**
4. リモートブランチが存在しない場合は自動プッシュ（`git push -u origin HEAD`）
5. **必ず `gh pr create --draft ...` で Draft PR として作成する**（通常 PR で作るのは禁止）
