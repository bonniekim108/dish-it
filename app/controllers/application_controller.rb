class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    # Slide the token expiraton if exists and not already expired
    if current_user && session[:dishItToken] && (session[:expires_at] > Date.today)
      session[:expires_at] = Date.today + 14.days
    else
      session[:dishItToken] = nil
    end
  end

  def current_user
    @current_user ||= User.find_by(:token, session[:dishItToken]) if session[:dishItToken]
  end
  helper_method :current_user

  def authorize
    current_user
  end

  def authorize_admin
    current_user && current_user.is_admin
  end

end
