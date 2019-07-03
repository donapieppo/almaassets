class Booking < ApplicationRecord
  belongs_to :server
  belongs_to :user

  validates :start_at, uniqueness: { scope: :server_id, message: "L'intervallo è già prenotato." }

  scope :future,  -> { where('start_at > NOW()') }
  scope :in_week, -> { where('start_at BETWEEN CURDATE() AND (CURDATE() + INTERVAL 7 DAY)') }
  scope :today,   -> { where('start_at BETWEEN CURDATE() AND (CURDATE() + INTERVAL 1 DAY)') }
end

