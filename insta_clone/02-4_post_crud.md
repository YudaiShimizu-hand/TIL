# Swiper

## yarnから読み込む


```
$ yarn init

$ yarn add Swiper

$ yarn install
```
https://qiita.com/kenkentarou/items/bdf04d8ecab6a855e50f

##　導入したファイルの読み込み

```javascript
application.js

//= require swiper/swiper-bundle.js
//= require swiper.js

//順番大事

```

```css

@import 'swiper/swiper-bundle';

```

/ バージョンで書き方が大きく変わる。

## jsファイルの作成

新しくJSファイルを自分で作成する必要があります。

```
app/assets/javascripts/任意の名前.js
```

公式サイトをみる


## 今回戸惑ったのは発火するタイミング

https://qiita.com/miketa_webprgr/items/0a3845aeb5da2ed75f82

https://qiita.com/YOUG_XX/items/00e5cb887b0bdcbcc334

https://teratail.com/questions/294975

このサイトをみる！

headとbodyにswiperを読み込ませる。

その後にbodyのswiperの下に
new swiperを書き込む！
