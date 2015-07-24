class CompaniesController < ApplicationController
    
    def new
            
    end    
    
    def show
        @comp = Company.find(params[:id])
    end

    def create
       @comp = Company.create(company_params)
       redirect_to company_path(@comp)
    end

    private
        def company_params
            params.require(:company).permit(:name, :email, :password, :password_confirmation, :street, :city, :state, :country)
        end
end
