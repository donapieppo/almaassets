class GoodPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    @user.is_admin? or record.user_id == @user.id
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    @user.is_admin?
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def find?
    @user.is_admin?
  end

  def unload?
    @user.is_admin?
  end

  def new_confirm?
    record.user_id == @user.id
  end

  def confirm?
    record.user_id == @user.id
  end

  def new_unconfirm?
    @user.is_admin? || record.user_id == @user.id
  end

  def unconfirm?
    @user.is_admin? || record.user_id == @user.id
  end

  def ask_category?
    @user.is_admin?
  end

  def set_category?
    @user.is_admin?
  end

  def print?
    @user.is_admin?
  end
end
