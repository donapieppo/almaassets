class Organization < ApplicationRecord
  has_many :locations
  has_many :users

  def to_s
    self.name
  end
end

