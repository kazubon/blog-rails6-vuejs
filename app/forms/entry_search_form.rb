class EntrySearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :tag, :string
  attribute :offset, :integer
  attribute :sort_key, :string
  attr_accessor :current_user, :user

  def initialize(current_user, user, params = {})
    @current_user = current_user
    @user = user
    super(params)
  end

  def assign_attributes(params)
    attribute_names.each {|name| send("#{name}=", params[name.to_sym]) }
  end

  def entries
    key = (sort_key == 'stars_count' ? :stars_count : :published_at)
    relation.preload(:user, :tags).order(key => :desc)
      .limit(20).offset(offset)
  end

  def entries_count
    relation.count
  end

  private
  def relation
    rel = if user
      user == current_user ? user.entries : user.entries.published
    else
      Entry.published
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