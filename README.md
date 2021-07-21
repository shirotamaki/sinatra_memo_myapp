# Name
メモしやがれ

# Description
Sinatraを使って作成したメモアプリです。
メモの新規作成、編集、削除が行えます。

# Demo
[![Image from Gyazo](https://i.gyazo.com/d903d20bde1430bfce5a6384c1518df0.gif)](https://gyazo.com/d903d20bde1430bfce5a6384c1518df0)

# install
## メモアプリをインストールしてください。
任意のディレクトリへ移動し、以下でGitHubリポジトリをクローンしてください。
```bigquery
$ git clone https://github.com/shirotamaki/sinatra_memo_app.git
```

`sinatra_memo_app` ディレクトリへ移動してください。
```bigquery
$ cd sinatra_memo_app
```

`bundle install` を実行し、必要なGemをインストールしてください。
```bigquery
& bundle install
```

## 事前にデータベースの作成が必要になります
PostgreSQLで自分のアカウントにログインしてください。
```bigquery
$ psql -U アカウント名
```
`memos`というデータベースを作成してください。
```bigquery
アカウント名=#  CREATE DATABASE memos;
```
psqlを一旦終了してください。
```bigquery
アカウント名=# \q
```
作成したデータベース`memos`へ接続してください。
```bigquery
$ psql -U アカウント名 memos
```
`t_memos`テーブルを作成してください。
````bigquery
CREATE TABLE t_memos
(id  serial NOT NULL,
title text NOT NULL,
content text,
PRIMARY KEY (id));
````

`myapp.rb`をrubyコマンドで実行すると、Sinatraを使ってサーバーが起動します。
```bigquery
$ ruby myapp.rb
```

ブラザウザへ下記URIを入力してください。
`http://localhost::4567/memos`