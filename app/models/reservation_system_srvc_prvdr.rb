class ReservationSystemSrvcPrvdr < ApplicationRecord
    belongs_to :reservation_system
    belongs_to :service_provider
end
