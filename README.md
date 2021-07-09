# Name
メモしやがれ

# Description
Sinatraを使って作成したメモアプリです。
メモの新規作成、編集、削除が行えます。

# Demo
[![Image from Gyazo](https://i.gyazo.com/d903d20bde1430bfce5a6384c1518df0.gif)](https://gyazo.com/d903d20bde1430bfce5a6384c1518df0)

# install

任意のディレクトリへ移動し、以下でGitHubリポジトリをクローンしてください。
```bigquery
$ git clone https://github.com/shirotamaki/sinatra_memo_app.git
```

`inatra_memo_app` ディレクトリへ移動してください。
```bigquery
$ cd sinatra_memo_app
```

`bundle install` を実行し、必要なGemをインストールしてください。
```bigquery
& bundle install
```

`myapp.rb`をrubyコマンドで実行すると、Sinatraを使ってサーバーが起動します。
```bigquery
$ ruby myapp.rb
```

ブラザウザへ下記URIを入力してください。
`http://localhost::4567/memos`
