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
