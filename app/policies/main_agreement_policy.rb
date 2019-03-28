class MainAgreementPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def new?
    @user.is_admin?
  end

  def create?
    @user.is_admin?
  end

  def edit?
    @user.is_admin?
  end

  def update?
    @user.is_admin?
  end

  def destroy?
    false
  end

end
