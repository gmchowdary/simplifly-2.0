class ContactPerson < ApplicationRecord
   
  belongs_to :contactable_person, polymorphic: true, optional:true,dependent: :destroy

  validates :first_name,:last_name,:phn_number,:email_id, presence: true
  validates :first_name, length: { maximum: 35}
  validates :last_name, length: { maximum: 35}
  validates :phn_number, length: {in: 10..15}
  validates :email_id, length:{maximum: 50},format: { with: /[0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/,message: "Invalid Email Id" }

end
