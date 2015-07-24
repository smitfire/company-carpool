class Carpool < ActiveRecord::Base

    # belongs_to :driver, class_name: "User"

    has_many :rides
    
    has_many :users, -> { uniq }, through: :rides

    has_one :driver_ride, -> {drivers}, class_name: 'Ride'
    
    has_one :driver,through: :driver_ride, source: :user
    
    has_many :passenger_rides, -> {passengers}, class_name: 'Ride'
    
    has_many :passengers, through: :passenger_rides, source: :user

    # has_one :driver, -> {  }, through: :rides
    # has_many :passengers, -> { uniq }, through: :rides, source: :user

    scope :available_rides, -> (user) { includes(:driver).where("id NOT IN (?)", user.carpools.pluck(:id)) }

    # extend SimpleCalendar
    # has_calendar


    def starts_at
        Date.today    
    end

    def time
        date.to_s[-12..-8]
    end

    def latitude
        driver.latitude
    end

    def longitude
        driver.longitude
    end

    def space?
        passengers.count < capacity
    end

    def seats_remaining
        capacity.nil? ? 0 : capacity - passengers.count
    end

end
