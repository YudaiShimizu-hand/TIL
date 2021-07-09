# pagination (kaminari)

gemのインストール

```
gem 'kaminari'
$ bundle
```

controllerの設定

例
```ruby
def index
  @users = User.page(params[:page]).per(10)
end

```

pageメソッド

perメソッド

引数によってレコードの数で表示を決めれる。


viewの設定

```
<%= paginate @users %>

```
これで表示


# 見た目を整える　for bootstrap

```
$ rails g kaminari:views bootstrap4
```

cssの設定

```css
.pagination {
  justify-content: center;
}
```

https://pikawaka.com/rails/kaminari

https://qiita.com/shun-takahashi/items/ed45d76e0f011e4f5b7b
