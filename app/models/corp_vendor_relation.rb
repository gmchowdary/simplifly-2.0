class CorpVendorRelation < ApplicationRecord
    belongs_to :corporate
    belongs_to :vendor
    has_many :corp_vendor_services
end
