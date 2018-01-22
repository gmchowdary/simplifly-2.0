class TpPolicy < ApplicationRecord
  has_many :tp_restrctns
    has_many :corporates,through: :tp_restrctns
  
end
