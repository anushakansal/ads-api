class SessionsController < ApplicationController

  def create
    @user = User.find_by email: auth_hash['info']['email']
    if @user
      #self.current_user = @user
    else
      @user = User.create(
        email: auth_hash['info']['email'],
        name: auth_hash['info']['name']
      )
    end
    session[:user_id] = @user.id
    redirect_to ENV['LOGIN_REDIRECT_URI']
  end

  def destroy
    reset_session
    redirect_to ENV['LOGOUT_REDIRECT_URI']
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end