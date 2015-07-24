class Ride < ActiveRecord::Base
    
    belongs_to :carpool

    belongs_to :user
    
    scope :drivers, -> { where(driver?: true) }
    
    scope :passengers, -> { where(driver?: false) }
    
    scope :all_addresses, -> { where( "longitude > ?", 0 ) }
    
    scope :all_incomplete_addresses, -> { where( "longitude is ?", nil) }

    # has_many :passenger_addresses, through: :passengers, source: :pickup_lnglats

    validates :carpool, :user, presence: true
    
    geocoded_by :address_str   # can also be an IP address
    after_validation :geocode, unless: "street.nil?"
         
    def address_str
        self.address_str = [street, city, state, country].compact.join(', ')    
    end
    
    def reverse_address_str_update(addr_str)
        keys = attributes.keys.select.with_index{|k,i| i.between?(9,12)}
        # vals = address_str.split(', ').to_hash
        vals = addr_str.split(', ').to_hash
        update(Hash[keys.zip(vals)])
        save
    end

    def passenger_addresses
        user.rides.where("id != ?", self.id).select(:address_str){ |ride| ride.longitude.present? }
    end
    
    protected
        def normalize_name
            self.name = self.name.downcase.titleize
        end
     
        def set_location
            # self.street = 
        end
        

        def add_address
            
        end


end
