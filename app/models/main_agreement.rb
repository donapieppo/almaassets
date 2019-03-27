class MainAgreement < ApplicationRecord
  belongs_to :category
  has_many   :good_requests

end
