class Organization < ApplicationRecord
  include DmUniboCommon::Organization

  has_many :permissions, class_name: "DmUniboCommon::Permission"

  has_many :locations
  has_many :goods
  has_many :good_requests
end

