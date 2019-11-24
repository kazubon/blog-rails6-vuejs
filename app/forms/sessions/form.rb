class Sessions::Form
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email, :string
  attribute  :password, :string
  attr_reader :user

  def authenticate
    return false unless email.present? && password.present?
    @user = User.authenticate(email, password)
  end
end