class Region < ApplicationRecord
    has_many :tp_exemptions, :as => :exemptionable, :dependent => :destroy
  has_many :tp_restrctns, :through => :tp_exemptions
end
