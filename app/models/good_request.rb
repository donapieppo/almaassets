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
    state :holder_approved, :accepted, :ordered, :arrived

    event :holder_approve do 
      transitions from: :requested, to: :holder_approved
    end

    event :accept do
      transitions from: :holder_approved, to: :accepted
    end
  end
end
