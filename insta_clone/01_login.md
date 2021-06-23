# ログイン
## 必要gem
* sorcery
認証のための最小限のロジックを詰んだgem。
libを簡単に取得できる。
```
gem 'sorcery'
```
bundle install
```
$ rails g sorcery:install
```
modelとmigrateファイルが生成される。

```
class SorceryCore < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email,            null: false
      t.string :crypted_password
      t.string :salt

      t.timestamps                null: false
    end
    add_index :users, :email, unique: true
  end
end

```
migrateファイル。
t.saltは
標準の暗号化では、「ソルト」を使用して、パスワードハッシュの安全性を高めます。 Sorceryでは、パスワードの末尾にランダムな文字列を結合し、その文字列をソルトフィールドに記憶することでこれを行います。

rails db:migrate

@tanutanuさんのQiita
https://qiita.com/tanutanu/items/52ceab22ad21ba97c902

* rubocop
Rubyの静的なコード解析を実行するgem
rubocopが.rbファイルに記述してあるコードを検査し、ここのコードは長すぎるね。とか、インデント入れたほうがいいよ。とかメソッド名変えようか。とかをコマンド１つでターミナルに吐き出しててくれます。

```
group :development do
  gem 'rubocop', require: false
end
# or
$ gem install rubocop
```
```
$ rubocop
#　解析して結果をターミナルに吐き出す。

$ rubocop --help
# ヘルプを参照できます。

$ rubocop --lint( または rubocop --rails )
# チェック規則は以下の4つに分類されますが --lint がLintのみチェック、 --rails がRailsのみチェック
# -------------------------------------------------------------------------
# 1 Style   (スタイルについて)
# 2 Lint    (誤りである可能性が高い部分やbad practiceを指摘する)
# 3 Metrics (クラスの行数や1行の文字数などに関して)
# 4 Rails   (Rails特有のcop)

$ rubocop --auto-gen-config 
# .rubocop_todo.ymlに警告を一旦退避する。
# .rubocop.ymlに "inherit_from: .rubocop_todo.yml" と書くのを忘れないでください。

$ rubocop --auto-correct 
```

rubocop.yml.zip

@tomohiiiさんのQiita
https://qiita.com/tomohiii/items/1a17018b5a48b8284a8b


* redis-rails
セッション情報の管理にRedisを使う。
```
gem "redis-rails"

$bundle
```
install

設定の修正
```
# config/application.rb
# /cache はアプリ名や、Rails．env等の環境情報をいれてもいいかも
config.cache_store = :redis_store, "redis://localhost:6379/0/cache", { expires_in: 90.minutes }

# ちなみに環境変数に入れてしまうのもおすすめです
# config.cache_store = :redis_store, ENV['REDIS_URL'], { expires_in: 90.minutes }
```
バックエンドの保存先
```
# config/initializers/session_store.rb
MyApplication::Application.config.session_store :redis_store, servers: "redis://localhost:6379/0/cache"

# 環境変数で設定する場合
#MyApplication::Application.config.session_store :redis_store, servers: ENV['REDIS_URL']

```
参考サイト
https://morizyun.github.io/blog/redis-rails-session-ruby/index.html

* rails-i18n
railsの他言語化対応

```
gem 'rails-i18n'

$bundle
```
設定情報の追加
```config/application.rb
...
module Habilidad
  class Application < Rails::Application
...
    # 言語ファイルを階層ごとに設定するための記述
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    # アプリケーションが対応している言語のホワイトリスト(ja = 日本語, en = 英語)
    config.i18n.available_locales = %i(ja en)

    # 上記の対応言語以外の言語が指定された場合、エラーとするかの設定
    config.i18n.enforce_available_locales = true

    # デフォルトの言語設定
    # config.i18n.default_locale = :en
    config.i18n.default_locale = :ja
...
  end
end
```
config/localesに多言語設定ファイル(*.yml)を配置する。
```
/my_application/config/locales
|--defaults          ## 共通系
|  |--en.yml
|  |--ja.yml
|--models            ## モデル系
|  |--model_name_A   ## 各モデルのディレクトリ
|  |  |--en.yml
|  |  |--ja.yml
|  |--model_name_B
|  |  |--en.yml
|  |  |--ja.yml
|--views             ## ビュー系
|  |--view_name_A    ## 各ビューのディレクトリ
|  |  |--en.yml
|  |  |--ja.yml
|  |--view_name_B
|  |  |--en.yml
|  |  |--ja.yml
```
参考
```
default/ja.yml
ja:                              ## 言語名
  dictionary:                    ## 共通系であることを示す
    title:                       ## 画面のタイトル
      create: "新規作成"
      update: "更新"
      destory:
        confirm: "削除確認"
    message:                     ## 固定メッセージ
      create:
        complete: "登録しました"
      update:
        complete: "更新しました"
      destory:
        confirm: "削除しますか？"
    button:                      ## 表示するボタン
      create: "新規作成"
      search: "検索"
      clear: "クリア"
      update: "更新"
      destory: "削除"
      cancel: "キャンセル"
  time:                          ## 表示する時間の形式
    formats:
      default: ! "%Y-%m-%d %H:%M:%S"

```
参考サイト
https://qiita.com/tsunemiso/items/bedc7593c7ccd05c395b

* annotate
各モデルのスキーマ情報をファイルの先頭もしくは末尾にコメントとして書き出してくれるGem.
schema.rbをみる手間を省く。
```
gem 'annotate'
$bundle
```
設定ファイルの作成
```
$ bundle exec rails g annotate:install
```
参考サイト
https://qiita.com/kou_pg_0131/items/ae6b5f41c18b2872d527

* better_errors
デフォルトのエラー画面をわかりやすく整形してくれる。
* binding_of_caller
better_errorsと一緒に使うことでブラウザ上のirbを使えるようになる。
```
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

$bundle
```
参考サイト
https://qiita.com/terufumi1122/items/a6f9a939dce25b2d9a3e

* pry-byebug
デバック、バグを修正するためのツール。
```
group :development, :test do
  gem 'pry-byebug'
end

$bundle
```

使用例
```
def create
  @user = User.new(user_params)

  binding.pry

  if @user.save
    flash[:success] = 'ユーザーを登録しました'
    redirect_to @user
  else
    flash[:danger] = 'ユーザーを登録しました'
    render :new
  end
end
```

binding.pryを書いたブレークポイントで処理が止まる。
参考サイト
https://qiita.com/ryosuketter/items/da3a38d0d41c7e20a2d6

* pry-rails
```
gem 'pry-rails'
$bundle
```
binfing.pry
pry-byebugと使うのがいい？



