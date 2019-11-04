class ArticleSearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :tag_name, :string
  attribute :tag_id, :integer
  attr_accessor :current_user, :user

  def initialize(current_user, user, params = {})
    @current_user = current_user
    @user = user
    super(params)
  end

  def search
    rel = if user
      user == current_user ? user.articles : user.articles.published
    else
      Article.published
    end

    if title.present?
      rel = rel.where('title LIKE ?', '%' + title + '%')
    end
    if tag_name.present?
      rel = rel.joins(:tags).
        where('LOWER(tags.name) = LOWER(?)', tag_name)
    end

    rel.preload(:user).preload(:tags).order(published_at: :desc)
  end
end