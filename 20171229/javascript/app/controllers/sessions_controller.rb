class SessionsController < ApplicationController
  def signin

  end

  def user_signin
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/', notice: "login success"
    else
      redirect_to '/signin', notice: "no memeber"
    end
  end

  def signup

  end
  def user_signup
    User.create( email: params[:email], password: params[:password],
      password_confirmation: params[:password_confirmation])
      # password_digest에 넣어줌 password_confirmation이랑 password가.
    redirect_to '/signin'
  end

  def signout
    session.delete(:user_id)
    redirect_to '/', notice: "logout success"
  end

end
