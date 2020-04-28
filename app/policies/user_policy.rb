class UserPolicy < ApplicationPolicy

  # see controller. User.sysncronize 
  def new?
    true
  end

  # see controller. User.sysncronize 
  def create?
    true
  end

end
