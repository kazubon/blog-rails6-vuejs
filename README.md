# Blog

Rails 6とVue.jsによるフォームのサンプルです。

## 動作環境

Ruby 2.6.4、Ruby on Rails 6.0, Webpacker 4, Vue.js 2.6

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
