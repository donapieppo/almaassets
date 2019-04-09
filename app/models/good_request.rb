class GoodRequest < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :category, optional: true
  belongs_to :main_agreement, optional: true
  belongs_to :holder, class_name: 'User', foreign_key: :holder_id, optional: true

  attr_accessor :outside_agreements
  
  def to_s
    self.name
  end
end

