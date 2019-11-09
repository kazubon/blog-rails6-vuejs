class ArticleSearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :tag, :string
  attr_accessor :current_user, :user

  def initialize(current_user, user, params = {})
    @current_user = current_user
    @user = user
    super(params)
  end

  def articles(options = {})
    relation.preload(:user, :tags).order(published_at: :desc)
      .limit(options[:limit]).offset(options[:offset])
  end

  def articles_count
    relation.count
  end

  private
  def relation
    rel = if user
      user == current_user ? user.articles : user.articles.published
    else
      Article.published
    end

    if title.present?
      rel = rel.where('title LIKE ?', '%' + title + '%')
    end
    if tag.present?
      rel = rel.joins(:tags).where('LOWER(tags.name) = LOWER(?)', tag)
    end

    rel
  end
end