class LoginForm
  include ActiveModel::Model

  attr_accessor :email, :password
  attr_reader :user

  def authenticate
    return false unless email.present? && password.present?
    @user = User.authenticate(email, password)
  end
end