class Airline < ApplicationRecord
    has_many :preferred_airlines
    has_many :corporate,through: :preferred_airlines
    belongs_to :preferred_airline
    
    def combined_id_name_code
         "#{self.id}|#{self.name}|#{self.code}"
    end
end
