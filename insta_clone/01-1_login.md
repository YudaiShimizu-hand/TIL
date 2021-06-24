# 学習ポイント

### git flowとは

５つのブランチによって開発を行う。
master　本番環境
↓
　↑ hotfix:masterのバグを修正するブランチ
↓
　relese:developからマスターに移す前に最終的なテストをする。
↓ ↑
develop:masterと同じ状態に保つ。ステージング環境
↓
feature:機能を増やす場合

[![Image from Gyazo](https://i.gyazo.com/c91f97894a0eb80e01bc6657d468e7d8.png)](https://gyazo.com/c91f97894a0eb80e01bc6657d468e7d8)

1日に複数回デプロイを行うようなwebアプリケーションに適している。
### ルール
* masterブランチは常にデプロイ可能である
* 作業用ブランチをmasterから作成する
* 作業用ブランチを定期的にプッシュする
* プルリクエストを活用する
* プルリクエストが承認されたらmasterへマージする
* masterへのマージが完了したら直ちにデプロイを行う

### 開発フロー
* 開発作業を行う
* プルリクエストを行う
* デプロイする

参考ページ
https://www.atmarkit.co.jp/ait/articles/1708/01/news015.html

## turbolink

画面推移を高速化させるライブラリ
rails newの段階から標準で組み込まれている。
asset piepelineというフレームワークの一部。

まず、ブラウザがページを表示するとき、通常は下記の様な流れで通信します。
１：ページ自体の HTML をダウンロードする。
２：ページの中で参照されているスタイルシートや Javascript をダウンロードする。
３：ページをレンダリングする。

この「２」の段階で、スタイルシートや Javascript が複数存在すると、
ブラウザと Web サーバの間で複数の通信が行われ、通信速度に影響を及ぼします。

そこで登場したのが、
「asset pipeline」というフレームワークです。
参考サイト
https://www.ryotaku.com/entry/2019/01/15/213420

## slimとは

Ruby製のテンプレートエンジン
HTMLタグを短く書くことができる。
```
gem 'slim-rails'
gem 'html2slim'
```

残ってるerbファイルをスリムにするコマンド
```
$  bundle exec erb2slim app/views/layouts/application.css
```

## database.yml
データベースと接続するための設定ファイル。

YAML形式
複雑なデータ構造をシンプルに表現するファイル形式

database.yml の中では、development , test , production という3種類の環境用に、それぞのデータベースの接続に必要な設定が記述されています。

書かれている項目

adapter
使用するデータベースの種類。
アダプタには各データベースに対応するsqlite3, postgresql, mysql2, oracle_enhanced などがあります。

* encoding
文字コード。
* pool
コネクション数の上限。
* database
データベース名

* username
データベースに接続するユーザー名

* password
データベースに接続するユーザーのパスワード

* host
データベースが動作しているホスト名またはIPアドレス

参考サイト
https://toomeeto.hatenablog.com/entry/2019/07/07/025205#:~:text=database.yml%E3%81%A8%E3%81%AF%E2%80%A6&text=%E3%83%87%E3%83%BC%E3%82%BF%E3%83%99%E3%83%BC%E3%82%B9%E3%81%A8%E6%8E%A5%E7%B6%9A%E3%81%99%E3%82%8B%E3%81%9F%E3%82%81,%E3%81%8C%E8%A8%98%E8%BF%B0%E3%81%95%E3%82%8C%E3%81%A6%E3%81%84%E3%81%BE%E3%81%99%E3%80%82
https://qiita.com/terufumi1122/items/b5678bae891ba9cf1e57

## migrationファイルとは

テーブル操作を行う仕組み
rubyで書かれたテーブルの設計図のこと。
データベースに直接書き込むと大変になるので消したりしやすいようにする。

マイグレーションで実現できること。
* テーブル作成
* テーブル削除
* カラム追加
* カラム名変更
* カラムのデータ型変更
* カラム削除

https://diveintocode.jp/blogs/Technology/migration

## schema.rbとは
DBの構造を確認したい時
migrationファイルとschema.rbは直接無関係
テーブル名とカラムの型とバリデーションが表示される。

## config/application.rb

* 初期化コードの置き場所

* Rails実行前にコードを実行する
アプリケーションでRails自体が読み込まれる前に何らかのコードを実行する必要が生じることがまれにあります。その場合は、実行したいコードをconfig/application.rbファイルのrequire 'rails/all'行より前に書いてください。

* Railsコンポーネントを構成する。
Rails全般に対する設定を行うには、Rails::Railtieオブジェクトを呼び出すか、Rails::EngineやRails::Applicationのサブクラスを呼び出します。

https://railsguides.jp/configuring.html

## yarnとは

node.jsで動作するパッケージマネージャー

node.jsとはjavascriptでサーバーサイドの処理を可能にさせるプログラム。

パッケージマネージャーとはコンピュータになんのソフトウェアがインストールされたかを記録し、新しいソフトウェアのインストール、更新、削除を容易にする。

https://qiita.com/Hai-dozo/items/90b852ac29b79a7ea02b
