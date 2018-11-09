class Good < ApplicationRecord
  belongs_to :user 
  belongs_to :cathegory

  def to_s
    self.name
  end

end
