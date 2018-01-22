class PreferredAirline < ApplicationRecord
    belongs_to :service_provider
    belongs_to :tp_restrctn
end
