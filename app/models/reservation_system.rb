class ReservationSystem < ApplicationRecord
    has_many :vendor_reservation_system_relations
    has_many :vendors,through: :vendor_reservation_system_relations
    has_many :reservation_system_srvc_prvdrs
    has_many :service_providers,through: :reservation_system_srvc_prvdrs
    belongs_to :reservation_system_type
    has_many :service_providers
    has_many :master_login_types
end
