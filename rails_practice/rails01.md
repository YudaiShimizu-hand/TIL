# Railsにおけるリクエストからレスポンスまでの流れ

## GET編
１、リクエストをする（/usersというurl）
２、リクエストに応じてroutes.rbでGetかPost、どのcontrollerのどのアクションでデータを処理するかを特定する。
３、特定した処理を〜controllerの〜アクションで実行
４、今回はGetメソッドなのでブラウザで表示する。view(html)を読み込んでレスポンスを返す。
５、modelはデータベース管理を行うのでPOST編で使う。


```
リクエスト＝＞           ＝＞ model ＜＝＞　データベース
            controller
レスポンス＜＝           ＝＞ view

```

# POST編

３つ目まではGETと同じ
４、Postではmodelを使ってデータベースにデータを保存する。
５、/tasks/newではparamsを使ってフォームに与えられたデータをform_withメソッドでデータを保存する。
６、/tasks ではデータを出力したいのでgetメソッドを使って取り出した値を表示する。

### exaample

```ruby
def new #(get)
    @tasks = Task.new #オブジェクトを作る。
end
```
```ruby
def create #(post)
    task = Task.new(tasks_params) #リクエストパラメーターを使ってオブジェクト作成
    task.save #保存
    redirect_to ~~~~~~~
end
```
```ruby 
private #リクエストパラメーター
def tasks_params
    params.require(:task).permit(:name)
    #{task:{~~~~~~~~}}
end

```
[![Image from Gyazo](https://i.gyazo.com/5a0f49d9e9f5f3a2fe85b056919d8fd6.png)](https://gyazo.com/5a0f49d9e9f5f3a2fe85b056919d8fd6)

[![Image from Gyazo](https://i.gyazo.com/055839b30d21dbc519ed6849abc7b476.png)](https://gyazo.com/055839b30d21dbc519ed6849abc7b476)



