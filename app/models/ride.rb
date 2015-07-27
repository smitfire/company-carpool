class Ride < ActiveRecord::Base
    
    belongs_to :carpool

    belongs_to :user
        
    scope :drivers, -> { where(driver?: true) }
    
    scope :passengers, -> { where(driver?: false) }
    
    scope :all_addresses, -> { where( "longitude > ?", 0 ) }
    scope :all_addresses, -> { where( "street is not ?", nil ) }
    
    scope :all_incomplete_addresses, -> { where( "longitude is ?", nil) }
    scope :all_incomplete_addresses, -> { where( "street is ?", nil) }

    has_many :passenger_addresses, through: :passengers, source: :pickup_lnglats

    validates :carpool, :user, presence: true
    
    geocoded_by :address_str   # can also be an IP address
    after_validation :geocode, unless: "street.nil?"
    after_save :lnglat, unless: "longitude.nil?"

    def address_str
        [street, city, state, country].compact.join(', ')
    end

    def lnglat
        [longitude, latitude]
    end
    
    def reverse_address_str_update(addr_str)
        keys = ["street","city", "state", "country"]
        vals = addr_str.split(', ')
        my_hash = Hash[keys.zip(vals)]
        save
    end

    def passenger_addresses
        user.rides.where("id != ?", self.id).select(:address_str){ |ride| ride.longitude.present? }
    end
    
    protected
        
end
