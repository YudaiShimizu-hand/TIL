# いいね機能(ajax)

## データベース

likes テーブル
```
t.references :user
t.references :post

t.index [:user_id, :post_id], unique: true
```

### index

インデックス（索引）は、データベースの性能を向上させる方法の一つです。インデックスは「探すレコードを識別するデータの項目」「対象レコードの格納位置を示すポインタ」で構成されており、これを利用してデータの格納位置を特定し、その位置を直接アクセスする事で、表の検索速度を上げることができます。インデックスが設定されていない場合の検索では、テーブルの最初から順番に1件ずつ探すため、時間がかかります.

https://www.atmarkit.co.jp/ait/articles/1703/01/news199.html

### unque
データベースの項目に付与する「他の行の値と重複しちゃダメよ制約」のこと

https://wa3.i-3-i.info/word12716.html


今回は同じユーザー・同じ投稿への「いいね！」が投稿できないように、DB側で制御をしています。


## アソシエーションの定義

has_manyとbelogs_toの記述

[![Image from Gyazo](https://i.gyazo.com/4a005745dd0b523fcbf61aa4bc4877e1.png)](https://gyazo.com/4a005745dd0b523fcbf61aa4bc4877e1)

コントローラーとusermodelに関する記述はサイトにて

https://qiita.com/tanutanu/items/b435af08aff706e01f2a
