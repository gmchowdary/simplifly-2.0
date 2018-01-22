class VendorService < ApplicationRecord
    belongs_to :vendor
    belongs_to :service
    has_many :corp_vendor_services
    validates_uniqueness_of :vendor_id, :scope => [:service_id], :message => "combination of service and Vendor should be unique."
end
