class Server < ApplicationRecord
  has_many :bookings

  after_create :create_api_key

  def to_s
    self.name
  end

  def self.get_by_api_key(k)
    self.where(api_key: k).first 
  end

  private 

  def create_api_key
    unless api_key
      self.update_attribute(:api_key, SecureRandom.urlsafe_base64(50))
    end
  end
end

