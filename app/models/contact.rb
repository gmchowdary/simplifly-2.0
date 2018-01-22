class Contact < ApplicationRecord
  
  belongs_to :contactable, polymorphic: true, optional:true,dependent: :destroy
  
  validates :addr1,:addr2,:district,:city,:state,:pincode,:phone_num,:email_id, presence: true
  validates :addr1, length: { maximum: 35 }
  validates :addr2, length: { maximum: 35}
  validates :district, length: { maximum: 30 }
  validates :city,  length: { maximum: 25 }
  validates :state, length: { maximum: 35}
  validates :country_id, presence: { message: "Select Country" }
  validates :pincode, length: {in: 6..9}
  validates :phone_num, length: {in: 10..15}
  validates :email_id, length:{maximum: 50},format: { with: /[0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/,
   message: "Invalid Email Id" }
   
end
