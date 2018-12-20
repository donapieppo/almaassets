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

  def find
    @user.is_admin?
  end
end
