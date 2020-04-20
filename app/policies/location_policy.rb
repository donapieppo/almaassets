class LocationPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    record_organization_manager?
  end
end

