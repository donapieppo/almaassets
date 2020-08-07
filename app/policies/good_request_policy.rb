class GoodRequestPolicy < ApplicationPolicy
  # see controller, only admins see them all
  def index?
    true
  end

  def create?
    owner_or_record_organization_manager?
  end

  def update?
    record_organization_manager? || (owner? && (! @record.holder_approved?))
  end

  def destroy?
    owner_or_record_organization_manager?
  end

  def print?
    approve?
  end

  def approve?
    @user && @record.holder_id == @user.id
  end
end
