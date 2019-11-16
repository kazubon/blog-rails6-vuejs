class ApplicationController < ActionController::Base
  class NotFound < StandardError; end

  private
  def require_login
    unless current_user
      redirect_to :new_session
    end
  end

  def current_user
    @current_user ||= begin
      if session[:user_id]
        user = User.find_by(id: session[:user_id])
        unless user
          session.delete(:user_id)
        end
      end
      user
    end
  end
  helper_method :current_user
end
