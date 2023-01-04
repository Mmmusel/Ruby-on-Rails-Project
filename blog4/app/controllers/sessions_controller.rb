class SessionsController < ApplicationController
  def create
    if user=User.authenticate(params[:name],params[:password])
      session[:user_id]=user.id
      redirect_to blogs_url
    else
      redirect_to login_url, :alert =>"invalid user"
    end
  end

  def new
  end

  def destroy
    session[:user_id]=nil
    redirect_to login_url :notice => "log out"
  end
end
