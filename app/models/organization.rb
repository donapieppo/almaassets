class Organization < ApplicationRecord
  include DmUniboCommon::Organization

  has_many :locations
  has_many :goods
  has_many :good_requests
  has_many :main_agreements
end

