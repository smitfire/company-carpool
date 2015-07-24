class User < ActiveRecord::Base
    
    belongs_to :company
    
    has_many :rides, -> { includes :carpool }, dependent: :destroy

    # has_many :addresses, through: :rides, source: :lng_lat
    
    has_many :carpools, -> {uniq}, through: :rides, source: :carpool, dependent: :destroy

    has_many :driver_rides, -> {drivers}, class_name: 'Ride', dependent: :destroy
    
    has_many :passenger_rides, -> {passengers}, class_name: 'Ride'
    
    has_many :driver_carpools, -> {uniq}, through: :driver_rides, source: :carpool, dependent: :destroy

    has_many :passenger_carpools, -> {uniq}, through: :passenger_rides, source: :carpool
    
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

    has_secure_password

    # after_validation :lnglats, unless: "rides.empty?"

    def addresses
        rides.select(:address_str){ |ride| ride.longitude.present? }
    end

    def lnglats
        rides.select(:longitude, :latitude){ |ride| ride.longitude.present? }
    end

    def pickup_lnglats
        passenger_rides.select(:longitude, :latitude) { |ride| ride.longitude.present? }
    end

    def driver_lnglats
        driver_rides.select(:longitude, :latitude) { |ride| ride.longitude.present? }
    end

    def start_time
        Date.today    
    end

    def appointments
        driver_carpools + passenger_carpools
    end
end
