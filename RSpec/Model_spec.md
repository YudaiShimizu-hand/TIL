# 明日やること

次のチャプター
Spec

redis-server /usr/local/etc/redis.conf

bundle config --local build.mysql2 "--with-ldflags=-L/usr/local/opt/openssl/lib"




# Rspec

## Rspecのセットアップ

* Gemfile

```
group :development, :test do

gem 'rspec-rails', '~> 3.6.0'

end
```
* テストデータベース

もし既存の Rails アプリケーションにスペックを追加するのであれば、もうすでにテストデータベース
を作ってあるかもしれません.

config/database.yml
```
test:
 <<: *default
 database: projects_test
```
mysql postgreSQLの場合こうなっている。

* Rspecの設定

```
$ bin/rails generate rspec:install
```
rspecのインストール

作成されたのは
RSpec 用の設定ファイル（.rspec ）
私たちが作成したスペックファイルを格納するディレクトリ（spec ）
のちほど RSpec の動きをカスタマイズするヘルパーファイル
（spec/spec_helper.rb と spec/rails_helper.rb ）

 .rspec ファイルを開き、以下のように変更
.rspec
 ```
--require spec_helper
--format documentation
 ```

 * rspec binstub を使ってテストスイートの起動時間を速くする

 binstub をインストール

 Gemfile
 ```
 group :development do

 gem 'spring-commands-rspec'

 end
 ```

 アプリケーションの bin ディレクトリ内に rspec という名前の実行用ファイルが作成されます。

 ```
 $ bundle exec spring binstub rspec
 ```
ちゃんとインストールできてるか確認

```
$ bin/rspec
または
$ bundle exec rspec spec/models/~~~~spec.rb
```

* ジェネレータ

rails generate コマンドを使ってアプリケーションにコードを追加する際に、RSpec 用のスペックファイルも一緒に作ってもらうよう Rails を設定

```ruby
config/application.rb
1 require_relative 'boot'
2 require 'rails/all'
3
4 Bundler.require(*Rails.groups)
5
6 module Projects
7 class Application < Rails::Application
8 config.load_defaults 5.1
9
10 # Rails が最初から書いているコメントは省略 ...
11
12 config.generators do |g|
13 g.test_framework :rspec,
14 fixtures: false, #ビュースペックを作成しないことを指定
15 view_specs: false, #ヘルパーファイル用のスペックを作成しないことを指定
16 helper_specs: false,#ヘルパーファイル用のスペックを作成しないことを指定
17 routing_specs: false #config/routes.rb 用のスペックファイルの作成を省略
18 end
19 end
20 end
```

## モデルスペック

手順
```
まず既存のモデルに対してモデルスペックを作ります。
それからモデルのバリデーション、クラスメソッド、インスタンスメソッドのテストを書きます。テストを作りながらスペックの整理もします。
```

テスト例
```
• 有効な属性で初期化された場合は、モデルの状態が有効（valid）になっていること
• バリデーションを失敗させるデータであれば、モデルの状態が有効になっていないこと
• クラスメソッドとインスタンスメソッドが期待通りに動作すること
```

```ruby
describe User do
    it "is valid with a last_name, fast_name, emaoil , and password"

    # 姓、名、メール、パスワードがあれば有効な状態であること
    it "is invalid withodt a first name"
    # 姓がなければ無効な状態であること
    it "is invalid without a last name"
    # メールアドレスがなければ無効な状態であること
    it "is invalid without an email address"
    # 重複したメールアドレスなら無効な状態であること
    it "is invalid with a duplicate email address"
    # ユーザーのフルネームを文字列として返すこと
    it "returns a user's full name as a string"
end

```
descirbe ... 期待する結果をまとめて記述、userモデルがどんなモデルなのか、どんな振る舞いをするのかを説明。

it ... 一つにつき結果を一つ期待している。
first name, last name, emailを分けて書く理由は原因をわかりやすくするため。

### モデルスペックを作成する。

まず、rspec:model generaterを実行。

spec/models/user_spec.rb

```ruby
 require 'rails_helper'
# ファイル内のテストを実行するために Rails アプリケーションの読み込みが必要で
あることを伝えています。
RSpec.describe User, type: :model do

    pending "add some examples to (or delete) #(_FILE_)"

end
```
bin/rspecコマンドで確認



 uninitialized constant Userというエラーでかなり苦しんだが、これはクラス名とファイル名が異なるときに起こる。
今回はテストする本体のモデルを作っていなかったのでおきていた。

spec/models/user_spec.rb
```ruby
require 'rails_helper'

RSpec.describe User, type: :model do
  # 姓、名、メール、パスワードがあれば有効な状態であること
  it "is valid with a first name, last name, email, and password"
  # 名がなければ無効な状態であること
  it "is invalid without a first name"
  # 姓がなければ無効な状態であること
  it "is invalid without a last name"
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address"
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address"
  # ユーザーのフルネームを文字列として返すこと
  it "returns a user's full name as a string"
end

```

