class Document < ApplicationRecord
  has_one_attached :attach
  belongs_to :main_agreement

  def to_s
    name
  end
end

