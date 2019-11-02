class Article < ApplicationRecord
  before_save { self.published_at ||= Time.zone.now }
end
