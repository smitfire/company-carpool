class User < ActiveRecord::Base
    belongs_to :company
    
    has_many :rides
    
    # has_many :addresses
    
    has_many :carpools, -> {uniq}, through: :rides

    has_many :driver_rides, -> {drivers}, class_name: 'Ride'
    
    has_many :passenger_rides, -> {passengers}, class_name: 'Ride'
    
    has_many :driver_carpools, through: :driver_rides, source: :carpool

    has_many :passenger_carpools, through: :passenger_rides, source: :carpool
    
    has_many :available_rides, ->(user) { where starts_on: user.birthday }, class_name: 'Event'
    
    # has_many :available_rides, -> { available_rides( ) }, class_name: "Ride"
    # has_many :available_rides, -> { }

    # has_many :available_carpools, through: :available_rides, source: :carpool

    # scope :available_rides, -> { Carpool.includes(:driver).where("id NOT IN (?)", carpools.pluck(:id)) }

    geocoded_by :address   # can also be an IP address
    after_validation :geocode
    
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

    has_secure_password
    
    # extend SimpleCalendar
    # has_calendar


    def start_time
        Date.today    
    end

    def address
        [street, city, state, country].compact.join(', ')
    end

    def appointments
        driver_carpools + passenger_carpools
    end
end
