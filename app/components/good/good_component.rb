class Good::GoodComponent < ViewComponent::Base
  def initialize(good, current_user, no_icon: false, search_string: nil)
    @good = good
    @current_user = current_user
    @no_icon = no_icon
    @search_string = search_string

    @good_policy = GoodPolicy.new(@current_user, @good)
    @manager = OrganizationPolicy.new(@current_user, @current_user.current_organization).manage?
    @found = @search_string && @good.inv_number == @search_string.to_i
  end
end
