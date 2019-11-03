class ArticleForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :body, :string
  attribute :draft, :boolean, default: false
  attribute :published_at, :datetime
  attribute :tags
  attr_accessor :user, :article

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 40000 }
  validate :check_tags

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
      article.update!(attributes.except('tags'))
      save_tags!
    end
    true
  end

  private
  def check_tags
    names = tags.collect {|t| t[:name] }.select {|n| n.present? }
    if names.any? {|n| n.size > 255 }
      errors.add(:tags, :too_long, count: 255)
    end
  end

  def set_published_at
    self.published_at ||= (article.created_at || Time.zone.now)
  end

  def save_tags!
    return unless tags.kind_of?(Array)
    names = tags.collect {|t| t[:name] }.select {|n| n.present? }.uniq {|n| n.downcase }
    new_tags = []
    names.each do |name|
      new_tags << (
        article.tags.detect {|t| t.name.downcase == name.downcase } ||
        Tag.search_by_name(name).first ||
        Tag.create!(name: name)
      )
    end
    article.tags = new_tags
  end
end