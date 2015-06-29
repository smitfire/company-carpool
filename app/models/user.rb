class User < ActiveRecord::Base
    belongs_to :company
    
    has_many :driver_carpools, class_name: "Carpool", foreign_key: "driver_id"
    
    has_many :rides
    has_many :passenger_carpools, -> { uniq }, through: :rides, source: :carpool
    
    geocoded_by :address   # can also be an IP address
    after_validation :geocode
    
    has_secure_password
    
    extend SimpleCalendar
    has_calendar


    def start_time
        Date.today    
    end

    def address
        [street, city, state, country].compact.join(', ')
    end

    def all_pools
        present_pools = driver_carpools.pluck(:id) + passenger_carpools.pluck(:id)
        Carpool.pluck(:id) - present_pools
    end

    def available_rides
        Carpool.find(all_pools)
    end

    def appointments
        driver_carpools + passenger_carpools
    end
end
