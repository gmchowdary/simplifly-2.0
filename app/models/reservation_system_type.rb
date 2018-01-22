class ReservationSystemType < ApplicationRecord
  has_many :reservation_systems
  belongs_to :service
end
