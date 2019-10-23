class UserPolicy < ApplicationPolicy
  def index?
    @user.is_admin?
  end

  def create?
    @user.is_admin?
  end

  def new?
    create?
  end
end

