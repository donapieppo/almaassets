class UploadPolicy < ApplicationPolicy
  # no record FIXME
  def new?
    create?
  end

  def create?
    @user.authorization.can_manage?(current_organization)
  end
end


