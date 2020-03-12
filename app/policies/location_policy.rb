class LocationPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    organization_manager?
  end
end

