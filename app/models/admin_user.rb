class AdminUser < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :vendor,optional: true
  validates :first_name,:last_name, presence: true,if: :check_password_confirmation
  validates :first_name,:last_name, length: { maximum: 35 },if: :check_password_confirmation
  validates :last_name, length: { maximum: 35 }
  
  def check_password_confirmation
    password_confirmation == nil
  end
end
