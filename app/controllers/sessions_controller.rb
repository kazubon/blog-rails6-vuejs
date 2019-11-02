class SessionsController < ApplicationController
  def new
    @form = LoginForm.new
  end

  def create
    @form = LoginForm.new(login_params)
    if @form.authenticate
      session[:user_id] = @form.user.id
      redirect_to :root
    else
      flash.now.alert = "メールアドレスまたはパスワードが一致しません。"
      render :new
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
