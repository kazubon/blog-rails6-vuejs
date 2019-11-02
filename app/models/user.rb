class User < ApplicationRecord
  attr_accessor :password

  def password=(password)
    self.hashed_password = BCrypt::Password.create(password)
    @password = password
  end

  def valid_password?(password)
    BCrypt::Password.new(hashed_password) == password
  end

  class << self
    def search_by_email(email)
      where("LOWER(email) = LOWER(?)", email)
    end

    def authenticate(email, password)
      user = search_by_email(email).first
      if user && user.valid_password?(password)
        user
      end
    end
  end
end
