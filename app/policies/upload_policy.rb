class UploadPolicy < ApplicationPolicy
  def new?
    @user.is_admin?
  end

  def create?
    @user.is_admin?
  end
end


