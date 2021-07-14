# +a

* has_many throughについて

```
has_many :like_users, through: :likes, source: :user
has_many :like_posts, through: :likes, source: :post
```
多対多

```ruby
class User < ApplicationRecord
  # 一人のユーザーは複数の投稿にいいねができる。
  has_many :likes, dependent: :destroy
  # ユーザーがいいねしている投稿を取得できるメソッド。中間テーブルのlikesテーブルを経由してpostsテーブルを参照する。user_idと対になってるpost_idの投稿を取ってくる。
  has_many :like_posts, through: :likes, source: :post
  #throughメソッドでlikes経由でlike_postsにアクセスできる。
end
```

https://qiita.com/samurai_runner/items/cbd91bb9e3f8b0433b99


## userモデルへのいいね機能のメソッド追加


```ruby
class User < ApplicationRecord
  # いいねをするメソッド
  def like(post)
    like_posts << post
  end

  # いいねを外すメソッド
  def unlike(post)
    like_posts.destroy(post)
  end

  # いいねしているかを確認するメソッド
  def like?(post)	 
    like_posts.include?(post)
  end
end

```

## link_toについて

link_to likes_path(post_id: post.id), method: :post, remote: true

このようにlink_toヘルパーの引数に上のように渡すことで /likes?post_id=3のようなURLを作成することができる。

https://qiita.com/hmuronaka/items/f27219d408d0b70d3f4d

* ajax

リンクからAjaxリクエストを送る => likesコントローラーでアクションを実行する => アクションに対応したjs.slimファイルをブラウザにレスポンスする

j関数は、javascriptコードとして認識してもらうため.
