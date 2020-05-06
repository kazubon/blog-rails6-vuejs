# Blog

[![blog-rails6-vuejs](https://circleci.com/gh/kazubon/blog-rails6-vuejs.svg?style=shield)](https://app.circleci.com/pipelines/github/kazubon/blog-rails6-vuejs)

Rails 6とVue.jsによるフォームのサンプルです。

解説：[Rails+Vue.jsによるフォームの作例](https://qiita.com/kazutosato/items/38caffdbd21508a5c126)

vue-routerを使ったバージョンはこちら: https://github.com/kazubon/blog-rails6-vuejs/tree/router

React版もあります: https://github.com/kazubon/blog-rails6-react

## 動作環境

Ruby 2.6.5、Ruby on Rails 6.0, Webpacker 4.2, Vue.js 2.6

非SPA、Turbolinksあり

## 開発環境の用意

```
$ bundle install
$ yarn install
$ bin/rails db:migrate
$ bin/rails db:seed
```

db/seeds/development/users.rb にあるユーザー（alice@example.com / password など）でログインしてください。

## 作っていない機能

- ユーザーの新規登録、アカウント管理
