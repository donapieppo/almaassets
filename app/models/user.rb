class User < ApplicationRecord 
  include DmUniboCommon::User

  has_many :goods
end


