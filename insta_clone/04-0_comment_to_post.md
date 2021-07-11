# rails [ajaxを使って]　コメント機能の実装
新規コメントのみ

## ルーディング

```
resources :posts, shallow: true do
  resources :comments
end
```
ネストするとルーディングが長くなってしまうので不要なルーディングを削除するためにshallowルーディングを使う。

## controller

class CommentsController < ApplicationController

```ruby
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comments = @post.comments.all
    @comment.save
    # 保存されたらrenderを使わないことで同じ名前のファイルにrenderされる
    # create.js.slim
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    @comment.destroy
    render :destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:comment, :post_id)
    end
end
```

```ruby
class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.all
  end
end
```

## view

```ruby
# コメント一覧表示
.row
  .col-lg-4
    .col-lg-4

      # create.js.erbで書き換えるため記述必須
      div id="comment-text"

        # コメント一覧部分をパーシャルで飛ばす
        = render 'comments/comment', comments: @comments


# コメントフォーム
  .row
    .col-lg-3
    .col-lg-6.text-center
      .frame-post-show

        # jsファイルを呼び出すためにlocal: trueの記述を外す
        = form_with(model: [@post, @comment]) do |f|

          = f.label :comment, class: "font-weight-bold col-lg-3 text-center"
          <br>
          = f.text_area :comment, :size=>"57x5"
          <br>

          .text-center= f.submit "コメントする", class: "btn btn-outline-secondary btn-sm"
```

コメント表示するのはここ

```ruby
# create.js.erbで書き換えるため記述必須
div id="comment-text"

  # コメント一覧部分をパーシャルで飛ばす
  = render 'comments/comment', comments: @comments
```

コメントフォームはパーシャルで描いてもいい

```ruby
= form_with model: [post, comment], class: 'd-flex mb-0 flex-nowrap justify-content-between', remote: true do |f|
 = f.text_field :body, class: 'form-control input-comment-body', placeholder: 'コメント'
 = f.submit '投稿', class: 'btn btn-primary btn-raised'
```

* ここでの注意はform_withがlocal:trueじゃなくremote: trueになってる。

remote: trueはajaxで使うデフォルトオプション

## モデルに紐付け

has_manyとbelongs_toを使う。

## create.js.slim

```ruby
| $('#comment-text').prepend("#{j render('comments/comment', comment: @comment)}");
# comment-textは先程のid
# その部分を_comment.html.slimの内容にページ推移なしで書き換える。
  | $('.input-comment-body').val('');
  # 空にする
```

https://qiita.com/waka_kawa/items/456e394b2e5156485488
