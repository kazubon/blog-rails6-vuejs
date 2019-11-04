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
    rel.preload(:user).order(published_at: :desc)
  end
end