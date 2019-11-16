class Star < ApplicationRecord
  belongs_to :entry, counter_cache: true
  belongs_to :user
end
