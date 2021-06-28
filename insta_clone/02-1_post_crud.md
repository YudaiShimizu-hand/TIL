# Fakerでダミーテキスト

導入

```
gem 'faker'

```

書き方
```
Faker::Name.name                 #=>フルネームの名前
Faker::Name.first_name           #=>firstnameだけ
Faker::Name.initials             #=>イニシャル
Faker::Name.initials(number: 2)　#=>2文字のイニシャル
```
Fakerの後に指定したいものを選択する。

基本的に公式に書いてある通りに記述すればOK

https://qiita.com/mumucochimu/items/10432fd5173e63ebd418

* gsubメソッド

文字列を別の文字へ置換する
正規表現を用いて該当する箇所を置換したり削除したりできる。

例)
正規表現を使わない場合
```
文字列.gsub(置換したい文字列, 置換後の文字列)
```
正規表現を使う場合

```
文字列.gsub(/正規表現/, 正規表現に該当した箇所を置換した後の文字列)
```

# ActiveRecord::Relationとは

クエリを生成するための情報を保持し、メソッドチェーンでつなげることができるため、再利用性が高く、便利なものになっている。

一方で、理解して使わないと、意図していないクエリを組み立ててしまい、パフォーマンスの悪化などを招くこともある。

以下のようなコードを書いた時、whereで返ってきたRelationに対してto_aを呼び出しているため、その段階でRubyの配列になっているため、その段階でデータベースにアクセスが走ってしまうこと、また既に配列になってしまっているため、ActiveRecordのメソッドであるwhereは使えないことに注意したい。
```ruby
new_users = User.where('created_at > ?', "2019-04-01").to_a
new_users.where(...)
```

## limitとtake

take...ActiveRecord::FinderMethodsのメソッドであり、データベースにアクセスを行い、レコードを取得する。

limit...imitはデータベースにアクセスしない。

* クエリとは...データの

## limitメソッド

取得するレコード数の上限

例)
```ruby
User.limit(5)
```
usersテーブルから最大5件を取得
