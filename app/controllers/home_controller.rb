class HomeController < ApplicationController

  def index
    if current_user.is_admin?
      redirect_to good_requests_path and return
    else
      @good_requests = current_user.good_requests
    end
  end

end


