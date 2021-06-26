# 投稿機能のCRUD機能を作ってください。

### データ型refernce型について

Railsで外部キーのカラムを追加する際に、reference型を使うことがある。

制約などなにもないカラムの作成
```ruby
t.integer  :user_id

```
インデックスを貼るカラムの作成
```ruby
t.integer   :user_id, index: true
or
add_index :tweets, :user_id
```
reference型を使うメリット
```ruby
t.references :user
```
user →　user_idを作成
インデックスを自動で降ってくれる。

しかし、外部キー制約はつきません

```ruby
t.references :user, foreign_key: true
```
foreign_key: true　これが使える。

https://qiita.com/ryouzi/items/2682e7e8a86fd2b1ae47

## seedファイルってなに？

初期データのこと

例えば、コーディング中に何らかの理由でデータベースをリセットした場合中に入っているデータももちろんですが消えてしまいます。
ですが、ユーザー登録機能がある場合リセットするたびに毎回ユーザー登録をし直す必要が出てきます。　　
仮にそれが普通のユーザーだった場合はそれでもいいかもしれませんが、アドミン権限をユーザーにrollカラムをつける形でアドミン権限の設定を行っていた場合、ユーザー登録のあとにコンソールでアドミン権限を付与するという2度手間になってしまいます。　

### 基本の書き方

```ruby
User.create!(
   email: 'test@test.com',
   name: 'テスト太郎',
   image: File.open('./app/assets/images/test.jpg')
)
```

### 複数のユーザーを一気に作る。

```ruby
5.times do |n|
    User.create!(
      email: "test#{n + 1}@test.com",
      name: "テスト太郎#{n + 1}",
      image: File.open('./app/assets/images/test.jpg')
    )
  end

```

### データベースに反映させる。

```ruby
$ rails db:seed

```

https://qiita.com/takehanKosuke/items/79a66751fe95010ea5ee


## Fakerでダーミーデータを生成する。

```
 gem 'faker'
 $ bundle
```
### Fakerで作成できる要素
https://github.com/faker-ruby/faker#generators

```
> Faker::Dessert.variety
=> "Upside Down Pineapple Cake"
> Faker::Address.city
=> "千葉市"
> Faker::Address.street_name
=> "真央"
> Faker::Address.zip
=> "191-3257"
> Faker::Address.street_address
=> "73696 桜"
> Faker::App.name
=> "Alpha"
```
この後にseedファイルを作る。

```ruby
5.times do
  user = User.create!(
    username: Faker::JapaneseMedia::StudioGhibli.character,
    email: Faker::Internet.email,
    password: 'foobar',
    password_confirmation: 'foobar',
  )
  puts "\"#{user.username}\" has created!"
end
```
結果
```
"Donald Curtis" has created!
"Chihiro Ogino" has created!
"Yupa" has created!
"Yupa" has created!
"Haku" has created!
```

https://qiita.com/tanutanu/items/4006bd868affa535adb0

## 画像をアップロード

```
gem 'carrierwave'
$ bundle
```
### アップローダーの作成

```
$ rails g uploader image
```

```
create app/uploaders/image_uploader.rb
```


### モデルの関連付け

user.rbにカラムの名前をmount_uploaderに指定

```ruby
mount_uploader :image, ImageUploader
```

ストロングパラメーターに:imageを追加。

user画像の場合
```ruby
<%= form_for(@user) do |f| %>
   <% if @user.image? %>
      <%= image_tag @user.image.url %>
   <% else %>
      <%= image_tag "/assets/default.jpg", :size => '100x100' %>
   <% end %>
      <button type="button" class="btn btn-outline-secondary rounded-pill">
         <%= f.file_field :image, accept: 'image/jpeg,image/gif,image/png' %>
      </button>
　　<%= f.submit '更新する', class: 'btn btn-primary' %>
<% end %>
```
https://qiita.com/nekotanku/items/5da43600f35eada64eac

## image_magicを使う。

rubyで使うにはRmagicをインストール」する。
インストール
```
$  brew install imagemagick@6  
```
```
gem 'rmagic'
$ bundle
```

### 画像を処理する方法。

```
require 'rubygems'

require 'RMagick'
```
画像を読み込む

```
image = Magick::Image.read('画像の名前').first
```

画像をリサイズする方法

```
# 元画像の画像サイズは1000x700とします。

image = image.resize_to_fit(700, 　70)

#=>小さい方の120にリサイズされます。

(100,70)へリサイズされます
```

例）
```ruby
#image.rb

require 'rubygems'

require 'RMagick'

image = Magick::Image.read('ohyama.png').first

image = image.resize_to_fit(700, 70)

image.write('ohyama1.png')

#=> 140,70の大きさにリサイズされる。
```
https://techacademy.jp/magazine/19896
