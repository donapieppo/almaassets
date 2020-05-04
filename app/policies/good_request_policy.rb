class GoodRequestPolicy < ApplicationPolicy
  # see controller, only admins see them all
  def index?
    true
  end

  def create?
    owner_or_record_organization_manager?
  end

  def update?
    owner_or_record_organization_manager?
  end

  def destroy?
    update?
  end

  def print?
    update?
  end

  def edit_approve?
    approve?
  end

  def approve?
    @user && @record.holder_id == @user.id
  end
end
