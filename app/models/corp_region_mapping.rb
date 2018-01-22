class CorpRegionMapping < ApplicationRecord
  belongs_to :corp_region
  belongs_to :country
end
