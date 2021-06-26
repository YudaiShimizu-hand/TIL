# 初期コマンド

## rails newの段階でgit flow initをする。
```
$ git clone ~~~~~
$ bundle init　＃Gemfileのインストール
$ Gemfileの中の#railsのコメントアウトを外して、バージョンを指定。
$ bundle install --path vendor/bundle  #Gemfileにリスト化したgemを一括インストール。
# --pathでインストール先を指定。最初に指定すれば次回行こうはbundle installでいい。
$ bundle exec rails new . -d mysql --skip-coffee --skip-turbolinks #--skip-coffee,--skip-turbolinksでセットアップをスキップ。
# bundle execはBundlerでインストールしたgemのパッケージを使ってコマンドを実行する。
$ git add .
$ git commit -m "initial commit"
$ git flow init #作業用リポジトリを作成、masterとdevelopができる。
$ git push --all #全てのブランチをpush
$ git flow feature start 01_~~~~~~~ #ブランチの作成。
```

```
$ brew install git-flow #インストールが必要な場合(mac)
```

```ruby
config/application.rb
module InstaClone
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.generators do |g|
      g.assets false
      g.test_framework false
      g.skip_routes true
  end
end
```
* generateコマンド時にassetsファイル、testファイル、routes.rbを自動生成させない。
