class GoodRequestPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.is_admin?
  end

  def create?
    @user and (@record.user_id == @user.id or @user.is_admin?)
  end

  def new?
    @user
  end

  def edit?
    @user and (@record.user_id = @user.id or @user.is_admin?)
  end

  def update?
    edit?
  end

  def destroy
    edit?
  end
end
