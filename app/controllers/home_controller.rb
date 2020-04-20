class HomeController < ApplicationController

  def index
    if policy(current_organization).edit?  
      redirect_to good_requests_path and return
    else
      @good_requests = current_user.good_requests
    end
  end

end


