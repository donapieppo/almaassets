class Good < ApplicationRecord
  belongs_to :organization
  belongs_to :user, optional: true
  belongs_to :category, optional: true
  belongs_to :location, optional: true

  validates :inv_number, uniqueness: {}
  # validates :name, presence: {}

  validate  :validate_user_upn

  def to_s
    self.name
  end

  def user_upn
    self.user_id ? self.user.upn : nil
  end

  def user_upn=(upn)
    Rails.logger.info("user_upn=#{upn}")
    if upn =~ /(\w+\.\w+@unibo.it)/ 
      @_user_upn = $1
    else
      @_user_upn= upn
    end
  end

  def validate_user_upn
    return true if @_user_upn.blank?

    Rails.logger.info("validating user_upn=#{@_user_upn}")

    u = User.find_by_upn(@_user_upn)

    if u
      Rails.logger.info("found #{@_user_upn} -> #{u.inspect}")
      self.user_id = u.id
    end
  end
 
  # we want the user to confirm every year
  def better_to_confirm
    ! (self.confirmed and (((Time.zone.now - self.confirmed).to_i/86400) < 365))
  end

  def confirm_presence(user)
    self.update_attributes(confirmed: Time.now, confirmed_by: user.id)
  end

  def unconfirm_presence
    self.update_attributes(confirmed: nil)
  end
end
