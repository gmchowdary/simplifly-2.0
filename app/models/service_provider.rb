class ServiceProvider < ApplicationRecord
    has_many :vendor_reservation_system_relations
    has_many :vendors,through: :vendor_reservation_system_relations
    has_many :reservation_system_srvc_prvdrs
    has_many :reservation_systems,through: :reservation_system_srvc_prvdrs
    belongs_to :reservation_system,optional: true

    has_many :preferred_airlines
    has_many :corporates, through: :preferred_airlines
    
     def combined_id_name_code
         "#{self.id}|#{self.name}|#{self.code}"
    end
end
