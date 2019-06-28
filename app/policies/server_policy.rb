class ServerPolicy
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
    new?
  end

  def edit?
    @user.is_admin?
  end

  def update?
    edit?
  end

  def destroy?
    @user.is_admin?
  end
end


