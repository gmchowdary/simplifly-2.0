class TpRestrctn < ApplicationRecord
    belongs_to :corporate
    belongs_to :tp_policy
    has_many :preferred_airlines
    has_many :cabin_classes
    has_many :paid_seats
    has_many :tp_exemptions, :dependent => :destroy
  has_many :levels, :through => :tp_exemptions, :source => :exemptionable, :source_type => 'Level'
  
  has_many :regions, :through => :tp_exemptions, :source => :exemptionable, :source_type => 'Region'
  
  has_many :users, :through => :tp_exemptions, :source => :exemptionable, :source_type => 'User'
  validates_uniqueness_of :tp_policy_id, :scope => [:corporate_id]
end
