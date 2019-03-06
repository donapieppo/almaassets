class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.is_admin?
  end

  def create?
    @user.is_admin?
  end

  def new?
    create?
  end
end

