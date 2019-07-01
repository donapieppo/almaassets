class Organization < ApplicationRecord
  has_many :goods
  has_many :locations
  has_many :users
  has_many :servers

  def to_s
    self.name
  end
end

