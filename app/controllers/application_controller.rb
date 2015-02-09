class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_cookies instead.
  protect_from_forgery with: :exception

  def index
    # Slide the token expiraton if exists and not already expired
    if current_user
      cookies[:dish_it_token] = { value: cookies[:dish_it_token], expires: 14.days.from_now }
    else
      cookies.delete(:dish_it_token)
    end
  end

  def current_user
    @current_user ||= User.find_by(token: cookies[:dish_it_token]) if cookies[:dish_it_token]
  end
  helper_method :current_user

  def authorize
    return true if Rails.env.development?
    current_user
  end

  def authorize_admin
    return true if Rails.env.development?
    current_user && current_user.is_admin
  end

end
