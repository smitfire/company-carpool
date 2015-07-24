class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if User.find_by_email(params[:user][:email])
      user = User.find_by_email(params[:user][:email])
      puts "="*100
      puts user.company
      puts user.company.id
      puts "="*100
      puts params[:company_id]
      puts "="*100
      if user && user.authenticate(params[:user][:password]) && user.company.id.to_s == params[:company_id]
        session[:user_id] = user.id
        flash[:notice] = "Succesfully logged in"
        redirect_to company_user_path(params[:company_id], user.id)
      else
        flash[:error] = "Authentication Failed, make sure you are in the right company"
        redirect_to '/'
      end
    else
      flash[:alert] = "Could not find user by that email"
      redirect_to '/'
    end
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/", :notice => "Signed Out!"
  end
end
