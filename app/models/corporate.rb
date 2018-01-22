class Corporate < ApplicationRecord
    has_one :contact, as: :contactable
    has_one :contact_person, as: :contactable_person
    has_one :admin_user
    has_many :vendor_services
    has_many :services,through: :vendor_services
    
    has_many :corp_vendor_relations
    has_many :vendors, through: :corp_vendor_relations
    accepts_nested_attributes_for :admin_user, :update_only => true
    
    accepts_nested_attributes_for :contact, :update_only => true
    accepts_nested_attributes_for :contact_person, :update_only => true
    
    validates :display_name,:registered_name,:pan_number,:gst_number, presence: true
    validates :display_name, length: { maximum: 35 }
    validates :registered_name, length: { maximum: 55}
    validates :subdomain_name, length: { maximum: 35 }
    validates :country_id, presence: { message: "Select Country" }
    validates :status, inclusion: { in: %w(E D), message: "Select Status" }
    validates :pan_number, length: {is: 10}
    validates :pan_number, uniqueness: true, on: :create
    validates :gst_number, length: {is: 15}
    validates :gst_number, uniqueness: true, on: :create
    
  
    before_save  :make_uppercase
    
    def make_uppercase
      self.registered_name.upcase!
    end
end
