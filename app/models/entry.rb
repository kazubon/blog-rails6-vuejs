class Entry < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :delete_all
  has_many :tags, through: :taggings
  has_many :stars, dependent: :delete_all

  scope :published, ->{ where(draft: false) }

  def readable_by?(current_user)
    !draft || user == current_user
  end

  def editable_by?(current_user)
    user == current_user
  end
end
