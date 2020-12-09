class HomeController < ApplicationController

  def index
    authorize :home
    if current_organization && policy(current_organization).manage?  
      redirect_to good_requests_path and return
    elsif current_organization
      @good_requests = current_user.good_requests.all
      @good_requests_as_holder = GoodRequest.where(holder_id: current_user.id).all
      @good_requests_as_holder -= @good_requests 
    else
      redirect_to choose_organization_path and return
    end
  end

  def choose_organization
    authorize :home
    if current_user_has_some_authorization?
      @organizations = current_user.my_organizations
    end
  end
end


