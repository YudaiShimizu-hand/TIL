# Login Logout機能の修正を行った。

session管理について調べまくった。

最初ボタンを押しても反応がなかったのですが、それを確認する方法としては
googleの開発者ツールを利用してできているのかを確認した。
redisでsesstion管理をしている場合は短いidにまとめられている。

logoutを押した時にlogoutがgetメソッドになってしまったのは、jquery-ujsが記載していなかったのが原因だった。

基本的にはjqueryが入ってなっかたのが原因
あとはform_with に　method: postではなく　local:trueと書いた。

そのほかはsourceryとredisの調べた通りで間違いはなかった。


# githubでrevertした後にmergeできなくなった問題

やり方は説明してくれている。
手順を踏んで解決する。

そしてredisのdump.rdbを中に入れなくてはいけない。
そのままは使えない。

```
$ redis-server /usr/local/etc/redis.conf
```
このコマンドでサーバーを起動させる。
dump.rdbのある場所を示している。
