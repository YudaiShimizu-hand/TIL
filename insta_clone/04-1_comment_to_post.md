# ajax コメント機能　削除、更新　modal

## 削除

controller

```ruby
def destroy
        @comment = current_user.comments.find(params[:id])
        @comment.destroy!
end

```

destroy.js.slimへ

```javascript
| $('#comment-#{@comment.id}').remove();

```
## 更新(modal)

controller

```ruby
def edit
        @comment = current_user.comments.find(params[:id])
end

# editは編集画面

def update
        @comment = current_user.comments.find(params[:id])
        @comment.update(comment_update_params)
end


private

def  comment_update_params
        params.require(:comment).permit(:body)
end

```

edit.js.slimとupdate.js.slimを書く

```javascript  
edit.js.slim

| $("#modal-container").html("#{escape_javascript(render 'modal_form', comment: @comment)}");
| $("#comment-edit-modal").modal('show');

//id　modal-containerを画面推移なしでmodal_formに書き換える.

```

```javascript
update.js.slim

| $("#comment-#{@comment.id}").replaceWith("#{j render('comments/comment', comment: @comment)}");
| $("#comment-edit-modal").modal('hide');

//replaceWithメソッドも要素を置き換える。
//よってcomment.idをcommentファイルに置き換える。

```

先程のmodal_formファイルを作成

```javascript
modal#comment-edit-modal
  .modal-dialog
    .modal-content
      .modal-header
        h5.modal-title コメント編集
        button.close aria-label="Close" data-dismiss="modal" type="button"
          span aria-hidden="true"  ×
      .modal-body
        = render 'form', post: nil, comment: comment

```

modalを反映させたいのでshared/_modal.html.slimを作る

```javascript
#modal-container
```

```ruby
application.html.slim

= yield
= render 'shared/modal'


```
