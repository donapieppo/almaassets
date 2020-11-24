class Category < ApplicationRecord
  has_many :goods
  has_many :good_requests
  has_many :main_agreements

  scope :buyable, -> { where(id: [1, 2, 3, 4, 5, 50]) }

  def to_s
    self.name
  end
end
