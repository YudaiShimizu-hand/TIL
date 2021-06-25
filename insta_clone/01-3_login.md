# rails-18n
モデル名、カラム名を日本語表記にしよう。

## config/application.rb

```ruby
# 言語ファイルを階層ごとに設定するための記述
   config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'acitverecord', '**', '*.{rb,yml}').to_s]
   # アプリケーションが対応している言語のホワイトリスト(ja = 日本語, en = 英語)
   config.i18n.available_locales = %i(ja en)
   # 上記の対応言語以外の言語が指定された場合、エラーとするかの設定
   config.i18n.enforce_available_locales = true
   # デフォルトの言語設定
   # config.i18n.default_locale = :en
   config.i18n.default_locale = :ja
```
ここ重要
```ruby
config.i18n.default_locale = :ja
```
defaultを日本語にしよう。

PATHを設定を行います。デフォルトではconfig/locales下の.rb、.ymlしか参照しません。
```ruby
 config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'acitverecord', '**', '*.{rb,yml}').to_s]
```
## config/locales
.yml or .rb しか使えない。

### acitverecord モデルの翻訳
(form_with model: @user, ~~~~~~~)

/model.ja.yml

```ruby
ja:
  activerecord: #定義
    models:
      user: "ユーザー"
    attributes:
      user:
        name: '名前'
        email: 'メールアドレス'
        password: 'パスワード'
        password_confirmation: 'パスワード確認用'
```
rails c にて確認
```ruby
> User.human_attribute_name(:email)
=> "メールアドレス"   # <= うまく設定できている!!
```

## viewテンプレートに対して翻訳

login画面

/ja.yml
```ruby
ja:
 user_sessions: #app/views/user_sessions と　user_sessions_controllerを指します
  new: #一階層下のnew.html.erb と sessions#newを指します。
    name: '名前'
    email: 'メールアドレス'
    password: 'パスワード'

```

new.html.erbを変更

``ruby
<%= f.label :email, (t '.email') %>
<%= f.label :password, (t '.password') %>
```

https://matazoukun.hatenablog.com/entry/2020/10/16/002424

https://qiita.com/shimadama/items/7e5c3d75c9a9f51abdd5
