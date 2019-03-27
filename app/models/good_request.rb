class GoodRequest < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :category, optional: true
  belongs_to :main_agreement, optional: true

  def to_s
    self.name
  end
end

