class Ride < ActiveRecord::Base
    
    belongs_to :carpool
    belongs_to :user

end
