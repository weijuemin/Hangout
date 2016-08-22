class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def require_login
    redirect_to "/" if session[:id] == nil
  end

  def current_user
    User.find(session[:id]) if session[:id]
  end
  helper_method :current_user

  def logged_in
    session[:id] == nil ? false : true
  end
end
