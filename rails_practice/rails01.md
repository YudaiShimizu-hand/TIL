# Railsにおけるリクエストからレスポンスまでの流れ

## GET編
１、webブラウザから/usersというUrlにGetリクエストをwebサーバに送る。
２、リクエストに応じてroutes.rbでどのcontrollerのどのアクションでデータを処理するかを特定する。
```ruby 
routes.rb
resources :users  #"/users" => "users#index"
```
３、特定した処理をUserscontrollerのindexアクションで実行
```ruby
userscontroller.rb
def index
    @users = User.all #userの全てのデータ
end
```
４、コントロラーではindexアクションに記述されているUserモデルに命令を出してUserモデルはデータベースから該当するコントローラに返す。
５、コントローラーは得られた結果をViewに渡してビューはHtmlを生成する。


## POST編
１、Webブラウザから/tasks/newというUrlにGetのリクエストをサーバーに送る。
２、Webサーバーはroutes.rbに定義されてるルーディングを元に利用されるコントローラ、アクションを決定する。
routes.rbにresources :tasksを記述してTasksコントローラのnewアクションに割り振られるレンダリングをする。
３、コントローラのnewアクションでTaskモデルをインスタンス化してformで送られる値をデータベースに保存できるように＠taskに代入する。
```ruby
    taskscontroller.rb
    def new
        @task = Task.new #空のTaskオブジェクトを作る
    end
```
その処理を元に、tasks/new.html.slimがレンダリングされる

4,タスク名を入力する（name)
form_withメソッドを使ってtasks/new.html.slim内に作成。

```ruby
# tasks/new.html.slim

= form_with model: @task, local: true do |f|
  .form-group
    = f.label :name
    = f.text_field :name, class: "form-control"
  = f.submit nil, class: "btn btn-primary"
```
↓このようなhtmlが生成される
```html
    <form action="/tasks" accept-charset="UTF-8" method="post">
  <input name="utf8" type="hidden" value="✔︎">
  <input type="hidden" name="authenticity_token" value="sajfosjf...">
  <div class="form-group">
    <label for="task_name">名称</label>
    <input class="form-control" type="text" name="task[name]">
  </div>
  <input type="submit" name="commit" value="登録する" class="btn btn-primary" data-disable-with="登録する">
</form>
```
５、form_withメソッドで生成されたHTML内のaction="/tasks"は送信先のURLです。
method="post"はHTTPメソッドのPostメソッドを使うことを指定。

６、作成ボタンを押す
/tasksへpostメソッドが送信される。
tasksコントローラー内のcreateアクションが実行
```ruby
def create #(post)
    task = Task.new(tasks_params) #リクエストパラメーターを使ってオブジェクト作成
    task.save #保存
    redirect_to @task #保存に成功したら詳細ページにリダイレクトする。
end
```
```ruby 
private #リクエストパラメーター
def tasks_params
    params.require(:task).permit(:name)#対照する属性を制限
    #{task:{~~~~~~~~}}
end
```
＊task_paramsを引数にとったTaskオブジェクトをtask変数に入れる。
[![Image from Gyazo](https://i.gyazo.com/5a0f49d9e9f5f3a2fe85b056919d8fd6.png)](https://gyazo.com/5a0f49d9e9f5f3a2fe85b056919d8fd6)

[![Image from Gyazo](https://i.gyazo.com/055839b30d21dbc519ed6849abc7b476.png)](https://gyazo.com/055839b30d21dbc519ed6849abc7b476)



