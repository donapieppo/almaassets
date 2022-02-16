class Good::GoodComponent < ViewComponent::Base
  def initialize(good, current_user, no_icon: false, search_string: nil)
    @good = good
    @no_icon = no_icon
    @search_string = search_string

    @can_edit = GoodPolicy.new(current_user, @good).edit?
    @found = @search_string && @good.inv_number == @search_string.to_i
  end
end
