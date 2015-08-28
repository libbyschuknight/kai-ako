class SessionsController < ApplicationController

  def new
    redirect_to '/auth/github'
  end

  def create
    @user = User.where(user_params).first_or_create

    if @user
      session[:user_id] = @user.id
      redirect_to profile_path
    else
      redirect_to root_url
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end

  protected

  def user_params
    request.env['omniauth.auth'].permit(:uid, :provider)
  end
end
