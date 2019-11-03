class Tag < ApplicationRecord
  has_many :taggings
  has_many :articles, through: :taggings

  class << self
    def search_by_name(name)
      where("LOWER(name) = LOWER(?)", name)
    end
  end
end
