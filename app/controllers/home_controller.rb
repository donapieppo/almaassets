class HomeController < ApplicationController

  def index
    @good_requests = current_user.good_requests
  end

end


