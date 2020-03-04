class GoodRequest < ApplicationRecord
  belongs_to :organization, optional: true
  belongs_to :user, optional: true
  belongs_to :category, optional: true
  belongs_to :main_agreement, optional: true
  belongs_to :holder, class_name: 'User', foreign_key: :holder_id, optional: true

  attr_accessor :outside_agreements

  include AASM
  
  def to_s
    self.name
  end

  aasm do
    state :requested, initial: true
    state :accepted, :ordered, :arrived

    event :accept do
      transitions from: :requested, to: :accepted
    end
  end
end

