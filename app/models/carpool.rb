class Carpool < ActiveRecord::Base

    belongs_to :driver, class_name: "User"

    has_many :rides
    has_many :passengers, -> { uniq }, through: :rides, source: :user

    extend SimpleCalendar
    has_calendar
    
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
