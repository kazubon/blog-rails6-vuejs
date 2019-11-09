json.articles do
  json.array! @articles do |article|
    json.id article.id
    json.title article.title
    json.path article_path(article)
    json.user_name article.user.name
    json.user_path user_articles_path(article.user)
    json.published_at article.published_at.try(:strftime, '%Y-%m-%d %H:%M')
    json.tags do
      json.array! article.tags do |tag|
        json.id tag.id
        json.name tag.name
        json.tag_path(@user ?
          user_articles_path(@user, q: { tag: tag.name }) :
          articles_path(q: { tag: tag.name })
        )
      end
    end
  end
end
json.articles_count @form.articles_count
