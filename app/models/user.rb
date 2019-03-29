class User < ApplicationRecord 
  include DmUniboCommon::User

  has_many :goods
  has_many :good_requests

  belongs_to :organization, optional: true
end


