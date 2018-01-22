class CorpVendorService < ApplicationRecord
  belongs_to :corp_vendor_relation
  belongs_to :vendor_service
end
