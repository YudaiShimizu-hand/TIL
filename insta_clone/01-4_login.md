# anotate
モデルのスキーマ情報をコメントとしてファイルに書き出してくれる。

```
gem 'annotate'
$bundle
```
## 設定ファイルの作成
lib/tasks/auto_annotate_models.rakeが作成されます。
```
$ bundle exec rails g annotate:install
```

## モデルのスキーマ情報を書き出してくれる。

```
($ rails g model User name:string email:string age:integer)
$ rails db:migrate
```
