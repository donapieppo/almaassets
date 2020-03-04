class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Pundit

  include DmUniboCommon::Controllers::Helpers
  include UserPermissionHelper # current_organization

  impersonates :user

  before_action :log_current_user, :force_sso_user, :retrive_authlevel
  after_action :verify_authorized, except: [:index, :who_impersonate, :impersonate, :shibboleth]

  def retrive_authlevel
    # tmp TODO FIXME
    session[:oid] = 1 unless session[:oid]

    if session[:oid]
      @current_organization = Organization.find(session[:oid].to_i)
    else
      redirect_to choose_current_organization
    end
  end

end
