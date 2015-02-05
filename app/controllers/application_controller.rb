class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #--- Every request will call the index action, thus calling authorize.
  #--- `authorize will  request will call the index action, thus calling authorize.


  # def index
  # end

  # def current_user
  #   @current_user ||= User.find(session[:carf_user_id]) if session[:carf_user_id]
  # end
  # helper_method :current_user

  # def authorize
  #   return current_user.exists?
  # end

  # def authorize_admin
  #   current_user && current_user.admin?
  # end

end
