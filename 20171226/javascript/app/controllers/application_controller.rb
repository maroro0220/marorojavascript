class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user
    if session[:user_id].nil?
      @user=nil
    else
      @user = User.find(session[:user_id])
  end
  helper_method :current_user
  def authorize
    redirect_to '/user/login' if current_user.nil?
  end
end
