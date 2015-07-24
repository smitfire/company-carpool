class Company < ActiveRecord::Base
    has_many :users

    geocoded_by :address   # can also be an IP address
    after_validation :geocode
    
    has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    validates_attachment_file_name :logo, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]
    
    has_secure_password

    def address
        [street, city, state, country].compact.join(', ')
    end
end
