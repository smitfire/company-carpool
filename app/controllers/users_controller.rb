class UsersController < ApplicationController

  def new
  end

  def create
  end

  def show
    @loc = request.location
    @user = User.includes(:company).find(params[:id])
    @available_rides = Kaminari.paginate_array(Carpool.available_rides(@user)).page(params[:page]).per(10)
    
  end

  def destroy
  end

  def new_release
    respond_to do |format|
        format.html
        format.js
    end
  end

  def map
    @user = User.includes(:company).find(params[:id])
    @cpools = Carpool.available_rides(@user)
    @cp2= @cpools.select{ |cp| cp.date.day >= Date.today.day }
    # @available_rides = Kaminari.paginate_array(Carpool.available_rides(@user)).page(params[:page]).per(20)    
    
    @hash = Gmaps4rails.build_markers(@cp2) do |cpool, marker|
    # @hash = Gmaps4rails.build_markers(@cpools) do |cpool, marker|
      marker.lat cpool.latitude
      marker.lng cpool.longitude
      # marker.infowindow "#{cpool.name} is leaving at #{cpool.date} and has #{cpool.seats_remaining} seats open"
      marker.infowindow render_to_string(:partial => "/users/info_map", :locals => { :object => cpool, user: @user})
    end
  end

  def calendar
    @user = User.includes(:company).find(params[:id])
    @meetings = @user.appointments
    render "_driver_cal"
  end

end
