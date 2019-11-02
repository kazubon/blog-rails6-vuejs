class Article < ApplicationRecord
  belongs_to :user
  has_many :tagggings
  has_many :tags, through: :tagggings

  scope :published, ->{ where(draft: false) }

  def readable_by?(current_user)
    !draft || user == current_user
  end

  def editable_by?(current_user)
    user == current_user
  end
end
