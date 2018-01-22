class VendorReservationSystemLogin < ApplicationRecord
    belongs_to :vendor_reservation_system_relation
    belongs_to :master_login_type
    validates :user_name,:password,:account_num, presence: true
    # validates :user_name, length: { maximum: 35 }
    # validates :password, length: { in: 6..15}
    validates :master_login_type_id, presence: { message: "Select Login Type" }
    # validates :account_num, length: {in: 10..15}
    validates :account_num, uniqueness: true, on: :create
    validates_uniqueness_of :vendor_reservation_system_relation_id, :scope => [:master_login_type_id], :message => "Credentials already exist for this login type", if:  :vendor_reservation_system_relation_id_check
    validates :status, inclusion: { in: %w(E D), message: "Select Status" }
 def vendor_reservation_system_relation_id_check
     puts "validatio true"
    puts vendor_reservation_system_relation_id.inspect
     vendor_reservation_system_relation_id != nil
 end
end
