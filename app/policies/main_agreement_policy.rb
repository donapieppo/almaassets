class MainAgreementPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    record_organization_manager?
  end

  def create?
    record_organization_manager?
  end

  def edit?
    record_organization_manager?
  end

  def update?
    record_organization_manager?
  end

  def destroy?
    record_organization_manager?
  end

end
