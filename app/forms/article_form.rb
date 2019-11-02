class ArticleForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :body, :string
  attribute :draft, :boolean, default: false
  attribute :published_at, :datetime
  attr_accessor :user, :article

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 40000 }

  def initialize(user, article, params = {})
    @user = user
    @article = article
    super(params)
  end

  def save
    return false unless valid?
    set_published_at
    article.user = user
    ActiveRecord::Base.transaction do
      article.update!(attributes)
    end
    true
  end

  private
  def set_published_at
    self.published_at ||= (article.created_at || Time.zone.now)
  end
end