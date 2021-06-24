# redis-railsもう少し詳しく

## 詳細
超高速のソフトウェアアップロード
[![Image from Gyazo](https://i.gyazo.com/37e62014dfccef4d30d5e1687d536823.png)](https://gyazo.com/37e62014dfccef4d30d5e1687d536823)
メモリ上に値に対して一意のキーをセットし、このペアを 保存するデータベースの一種です。
セッション・・・複数リクエストを同一のユーザーによるものと認識すること
クッキー・・・セッションを実現するための手段

* セッションとクッキーについて
通常、http通信はステートレスと言われ、それぞれの通信は独立しているが、それだと例えばログインしているユーザーが通信を行うためたびに毎回確認が必要になってしまうので、クッキーという手段を使って、同じログインユーザーのリクエストを同一のユーザーによるものと認識するセッションを実現します。

* セッション情報の保存場所をredisにする理由
サーバ複数台構成になってロードバランサで処理分散した場合にセッション情報を使い回せるように
デフォルトのクッキーストアはセキュリティ的に脆い →厳密のいうと、デフォルトのクッキーストアでも暗号化されてブラウザに保存されるのでなりすましなどのリスクが高いわけではないが。

## redisを使ってセッションの管理方法をcookieでなくredisにする。

### redis-rails を用いてフラグメントキャッシュストアで設定

* redisのダウンロード
```
$ brew install redis
```

* gem
```
gem 'redis-rails'
$ bundle
```
* 設定
config/environments/development.rb(例
```
Rails.application.configure do
  # 省略

  config.session_store :redis_store, servers: 'redis://localhost:6379/0/cache', expire_after: 1.day

  # 省略
end
```
'redis://localhost:6379/0/cache'の記述は、以下のように分解できます、
'redis://[ホスト名]:[ポート]/[db]/[namespase]'。

```
$bundle exec rails s
$ redis server
```
この２つを別のターミナルで起動

```
$redis-cli

127.0.0.1:6379> keys *
1) "2::f7e173d9971def6ddc129d5e938a4ed5d1d0046b3b5020add20c5f49e4cede82"
# 以下省略

```
このコマンドで保存されてるのを確認する。

### redis-rails を用いてセッションストレージストアで設定

config/initializers/session_store.rbを作成します

```
Rails.application.config.session_store :redis_store, expire_after: 1.day, servers: {
  host: "localhost",
  port: 6379,
  #password: 'password', 今回は使わない
  db: 1,
  namespace: "session",
  signed: true, # 署名、暗号化されたcookieを使用する
  secure: true # HTTPS 接続でサーバーからクライアントにcookieが転送されるようにする
}
```
再び
```
$bundle exec rails s
$ redis server
```
この２つを別のターミナルで起動

```
$redis-cli

127.0.0.1:6379> keys *
1) "2::f7e173d9971def6ddc129d5e938a4ed5d1d0046b3b5020add20c5f49e4cede82"
# 以下省略

```
