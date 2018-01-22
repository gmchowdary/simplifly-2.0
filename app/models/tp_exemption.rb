class TpExemption < ApplicationRecord
  belongs_to :exemptionable, polymorphic: true
  belongs_to :tp_restrctn
end
