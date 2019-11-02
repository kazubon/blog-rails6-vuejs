json.article do
  json.title @article.title
  json.body @article.body
  json.published_at (@article.published_at || Time.zone.now).strftime('%Y-%m-%d %H:%M')
  json.draft @article.draft
end
json.http_method @article.new_record? ? 'post' : 'patch'
json.path @article.new_record? ? articles_path : article_path(@article)