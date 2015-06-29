class CarpoolsController < ApplicationController
    def index
        
    end

    def show
        
    end
    
    def new
        
    end
    
    def create
        user = User.find(params[:user_id])
        user.driver_carpools.create!(carpool_params)
        flash[:notice] = "Carpool succesufully created"
        redirect_to user_path(user.id) 
    end

    def update
        
    end
    
    def join_carpool
        carp=Carpool.find(params[:id])
        carp.passengers << User.find(params[:user_id])
        flash[:notice] = "Joined " + carp.name + "on " + carp.date.to_s
        redirect_to :back
    end    
    
    def destroy
        
    end

    def carpool_params
        params.require(:carpool).permit(:name, :date, :capacity)
    end
end
