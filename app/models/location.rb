class Location < ApplicationRecord
  belongs_to :organization
  belongs_to :building
  has_many   :goods

  # vogliamo che inizi con una lettera o sia solo -
  validates :name, format: { with: /\A[\w _-]+\Z/, message: "Formato non corretto nel nome dell'ubicazione" }
  validates :name, uniqueness: { scope: [:organization_id], message: "Ubicazione già presente nella Struttura" }
  validates :organization_id, presence: true

  before_destroy :check_no_associated_goods, prepend: true # http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html

  def to_s
    self.name.upcase
  end

  protected

  def check_no_associated_goods
    if (self.goods.count > 0) 
      errors.add(:base, "Ci sono oggetti in questa ubicazione da spostare prima di poterla cancellare.")
      throw :abort
    end
  end
end
