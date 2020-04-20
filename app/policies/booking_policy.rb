class BookingPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    true
  end

  def create?
    new?
  end

  def destroy?
    owner?
  end

  def hg?
    true
  end
end


