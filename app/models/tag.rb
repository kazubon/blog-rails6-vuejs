class Tag < ApplicationRecord
  has_many :taggings, dependent: :delete_all
  has_many :entries, through: :taggings

  class << self
    def search_by_name(name)
      where("LOWER(name) = LOWER(?)", name)
    end
  end
end
