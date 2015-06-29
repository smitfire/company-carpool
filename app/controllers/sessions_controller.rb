class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if User.find_by_email(params[:user][:email])
      user = User.find_by_email(params[:user][:email])
      if user && user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        redirect_to user_path(user.id)
      else
        redirect_to root_path
      end
    else
      flash[:alert] = "Failed to log in"
      redirect_to '/'
      # user = User.create!(name: params[:user][:name], email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
      # session[:user_id] = user.id
      # redirect_to user_path(user.id)
    end
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed Out!"
  end
end
