class Star < ApplicationRecord
  belongs_to :entry, counter_cache: true
  belongs_to :user

  class << self
    def put(user, entry)
      if user && user != entry.user
        if entry.stars.exists?(user: user)
          entry.stars.where(user: user).destroy_all
        else
          entry.stars.create!(user: user)
        end
      end
      entry.stars_count
    end
  end
end
