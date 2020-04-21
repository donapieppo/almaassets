class UploadPolicy < ApplicationPolicy
  # no record FIXME
  def new?
    create?
  end

  def create?
    @user.authorization.can_manage?(@record.organization_id)
  end
end


