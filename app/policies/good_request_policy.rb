class GoodRequestPolicy < ApplicationPolicy
  # see controller, only admins see them all
  def index?
    true
  end

  def create?
    @user and (@record.user_id == @user.id or @user.is_admin?)
  end

  def update?
    @user and (@record.user_id == @user.id or @user.is_admin?)
  end

  def destroy?
    edit?
  end

  def print?
    edit?
  end
end
