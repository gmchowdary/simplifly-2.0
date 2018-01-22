class VendorReservationSystemRelation < ApplicationRecord
    has_many :vendor_reservation_system_logins
    belongs_to :vendor
    belongs_to :reservation_system,optional: true
    belongs_to :service_provider,optional: true
    accepts_nested_attributes_for :vendor_reservation_system_logins, :update_only => true 
    validates_uniqueness_of :vendor_id, :scope => [:reservation_system_id,:service_provider_id], :message => "Combination of Service,reservation_system and Vendor should be unique."
    validates :reservation_system_id, numericality: { other_than: 0, message: "Select Reservation System" },allow_blank: true
    validates :service_provider_id, presence: { message: "Select Service Provider" }, if: :reservation_system_id_check
    validates :status, inclusion: { in: %w(E D), message: "Select Status" }
                #  validates_uniqueness_of :vendor_id, :scope => [:service_provider_id], :message => "combination of service and Vendor should be unique.", :if => :reservation_system_id?
           
#  def service_provider_id?
#     service_provider_id == nil
# end

 def reservation_system_id_check
     puts "system"
     puts "validatio true"
    puts reservation_system_id.inspect
    reservation_system_id != 0 and reservation_system_id == nil
end
end


