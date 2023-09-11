class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id

    if session[:return_path].present?
      path = session[:return_path]
      session.delete(:return_path)
    else
      path = root_path
    end

    redirect_to path, notice: 'Successfully signed in!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Successfully signed out!'
  end

  def failure
    redirect_to root_path, alert: 'Authentication failed, please try again.'
  end
end
