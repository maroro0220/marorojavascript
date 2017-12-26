class UserController < ApplicationController
  def new

  end
  def create
    User.create(email: params[:email], password_digest: params[:password])
    @user=User.last
  end

  def index
    @users=User.all
  end

  def login

  end

  def login_process
    user=User.find_by(email: params[:email])
    if user.nil?
      flash[:alert]="NO Member"
      redirect_to "/new"
    else
      if user.password_digest==params[:password]
    end

  end

  def logout

  end


end
