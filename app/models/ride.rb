class Ride < ActiveRecord::Base
    
    belongs_to :carpool
    
    belongs_to :user
    
    scope :drivers, -> { where(driver?: true) }
    
    scope :passengers, -> { where(driver?: false) }
    
    # scope :available_rides, ->(user_id) { where.not(user_id: user_id) }
    
end
