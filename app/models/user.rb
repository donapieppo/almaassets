class User < ApplicationRecord 
  include DmUniboCommon::User

  default_scope { order(:surname, :name) }

  has_many :goods
  has_many :good_requests

  belongs_to :organization, optional: true

end


