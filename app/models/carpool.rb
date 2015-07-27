class Carpool < ActiveRecord::Base

    has_many :rides, -> { includes :user }, dependent: :destroy

    # has_many :rides, before_add: :check_credit_limit
    
    has_many :users, -> { uniq }, through: :rides

    # has_many :addresses, -> { passengers }, class_name: "Ride"
    
    has_one :driver_ride, -> {drivers}, class_name: 'Ride'
    
    has_one :driver, through: :driver_ride, source: :user
    
    has_one :company, through: :driver, source: :company
        
    has_many :passenger_rides, -> {passengers}, class_name: 'Ride'
    
    has_many :passengers, -> {uniq}, through: :passenger_rides, source: :user

    scope :available_rides, -> (user) { includes(:driver).where("id NOT IN (?)", user.carpools.pluck(:id)) }

    def pickup_addresses
        passenger_rides.select(:longitude, :latitude)
    end

    def destination_address
        driver_ride.select(:longitude, :latitude)
    end
    
    def starts_at
        Date.today    
    end

    def time
        date.to_s[-12..-8]
    end

    def latitude
        driver_ride.latitude
    end

    def longitude
        driver_ride.longitude
    end

    def space?
        passengers.count < capacity
    end

    def seats_remaining
        capacity.nil? ? 0 : capacity - passengers.count
    end

    def destination
        driver.company.address
    end

    private
        
        def check_credit_limit
            
        end
end
