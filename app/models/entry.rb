class Entry < ApplicationRecord
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings

  scope :published, ->{ where(draft: false) }

  def readable_by?(current_user)
    !draft || user == current_user
  end

  def editable_by?(current_user)
    user == current_user
  end
end
