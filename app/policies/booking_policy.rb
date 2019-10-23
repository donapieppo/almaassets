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
    @record.user_id = @user.id
  end

  def hg?
    true
  end
end


