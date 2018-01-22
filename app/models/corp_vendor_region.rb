class CorpVendorRegion < ApplicationRecord
  belongs_to :corp_region
  belongs_to :corp_vendor_relation
  belongs_to :service
end
