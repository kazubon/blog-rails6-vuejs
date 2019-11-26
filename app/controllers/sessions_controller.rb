class SessionsController < ApplicationController
  wrap_parameters :user

  def new
    @form = Sessions::Form.new
  end

  def create
    @form = Sessions::Form.new(login_params)
    if @form.authenticate
      session[:user_id] = @form.user.id
      render json: { location: user_entries_path(@form.user) }
    else
      render json: { alert: 'メールアドレスまたはパスワードが一致しません。' },
        status: :unprocessable_entity
    end
  end

  def destroy
    session.delete :user_id
    redirect_to :root, notice: 'ログアウトしました。'
  end

  private
  def login_params
    params.require(:user).permit(:email, :password)
  end
end
