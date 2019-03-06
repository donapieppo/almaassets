class User < ApplicationRecord 
  include DmUniboCommon::User

  has_many :goods
  belongs_to :organization, optional: true
end


