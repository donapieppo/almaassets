class Booking < ApplicationRecord
  belongs_to :server
  belongs_to :user

  scope :future, -> { where('start_at > NOW()') }
  scope :in_week, -> { where('start_at BETWEEN CURDATE() AND (CURDATE() + INTERVAL 7 DAY)') }

end

