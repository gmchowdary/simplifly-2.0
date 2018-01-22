class MasterLoginType < ApplicationRecord
    has_many :vendor_reservation_system_logins
    belongs_to :reservation_system
end
