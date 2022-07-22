# Contributing guide

- 1 修正 1 ベンチ
- ローカルで各種修正を行い、デプロイを行い、ベンチ通ったら commit の上 GitHub に push する
- デプロイは make コマンドを利用して行う
- PR は出さずに main ブランチにのみ push する
  - main 以外のブランチは作成しない
  - push されたら pull 忘れないこと
  - コンフリクトが起きないようにチーム内でコミュニケーションをとる
    - 例: 「今から `main.py` いじりま〜す」
- サーバ上で Vim 使うのはアリか？
  - `scripts/` 配下のスクリプトで管理していないもの以外は OK
  - 最悪やっても OK
    - チーム内に連携する
- commit message にはスコアだけを入力する
  - 例: `1532`
  - 参考: https://github.com/matsuu/isucon11q/commits/main
