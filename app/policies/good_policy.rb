class GoodPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    owner_or_record_organization_manager?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    record_organization_manager?
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def find?
    record_organization_manager?
  end

  def unload?
    record_organization_manager?
  end

  def new_confirm?
    owner_or_record_organization_manager?
  end

  def confirm?
    owner_or_record_organization_manager?
  end

  def new_unconfirm?
    owner_or_record_organization_manager?
  end

  def unconfirm?
    owner_or_record_organization_manager?
  end

  def ask_category?
    record_organization_manager?
  end

  def set_category?
    record_organization_manager?
  end

  def print?
    record_organization_manager?
  end

  def read_admin_notes?
    record_organization_manager?
  end
end
