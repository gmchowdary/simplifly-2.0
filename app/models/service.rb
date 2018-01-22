class Service < ApplicationRecord
    has_many :vendor_services
    has_many :vendors,through: :vendor_services
    has_many :reservation_systems

end
