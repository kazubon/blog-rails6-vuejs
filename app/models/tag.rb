class Tag < ApplicationRecord
  has_many :tagggings
  has_many :articles, through: :tagggings
end
