class Building < ApplicationRecord
  has_many   :locations

  # vogliamo che inizi con una lettera o sia solo -
  validates :name, format: { with: /\A[\w _-]+\Z/, message: "Formato non corretto nel nome dell'ubicazione" }
  validates :name, uniqueness: { scope: [:organization_id], message: "Ubicazione già presente nella Struttura" }

  def to_s
    self.name.upcase
  end
end
