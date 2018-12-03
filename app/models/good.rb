class Good < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :cathegory, optional: true

  validates :inv_number, uniqueness: {}

  def to_s
    self.name
  end

end
