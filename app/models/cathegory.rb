class Cathegory < ApplicationRecord
  has_many :goods

  def to_s
    self.name
  end
end
