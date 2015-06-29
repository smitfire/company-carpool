class UsersController < ApplicationController

  def new
  end

  def create
  end

  def show
    @user = User.find(params[:id])
    @available_rides = Kaminari.paginate_array(@user.available_rides).page(params[:page]).per(10)
    # @meetings = Carpool.all

    # @users = User.all
    # @hash = Gmaps4rails.build_markers(@users) do |user, marker|
    #   marker.lat user.latitude
    #   marker.lng user.longitude
    # end

  end

  def destroy
  end

  def new_release
    respond_to do |format|
        format.html
        format.js
    end
  end

  def calendar
    @user = User.find(params[:id])
    @meetings = @user.appointments
    render "_driver_cal"
  end

end
