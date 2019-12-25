class Entries::SearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :tag, :string
  attribute :offset, :integer
  attribute :sort, :string
  attr_accessor :current_user, :user

  def initialize(current_user, user, params = {})
    @current_user = current_user
    @user = user
    super(params)
  end

  def entries
    key = (sort == 'stars' ? :stars_count : :published_at)
    relation.preload(:user, :tags).order(key => :desc)
      .limit(20).offset(offset)
  end

  def entries_count
    relation.count
  end

  def query
    attrs = attributes.except('offset')
    user ? attrs.merge('user_id' => user.id) : attrs
  end

  private
  def relation
    rel = if user
      user == current_user ? user.entries : user.entries.published
    else
      Entry.joins(:user).merge(User.active).published
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