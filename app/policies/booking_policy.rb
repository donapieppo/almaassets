class BookingPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    new?
  end

  def destroy?
    @record.user_id = @user.id
  end
end


