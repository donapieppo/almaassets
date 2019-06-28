class Server < ApplicationRecord
  has_many :bookings

  def to_s
    self.name
  end
end

