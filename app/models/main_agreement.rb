class MainAgreement < ApplicationRecord
  belongs_to :category
  has_many   :documents
  has_many   :good_requests

  def to_s
    self.title
  end
end
