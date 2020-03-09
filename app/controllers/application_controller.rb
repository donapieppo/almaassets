class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Pundit

  include DmUniboCommon::Controllers::Helpers
  include UserPermissionHelper # current_organization

  impersonates :user

  before_action :log_current_user, :force_sso_user, :set_organization, :retrive_authlevels
  after_action :verify_authorized, except: [:index, :who_impersonate, :impersonate, :shibboleth]

  # We set organization with params[:__org__] as organization_id in config/routes
  def set_organization
    if params[:__org__]
      session[:oid] = params[:__org__].to_i 
    end
    # fallback to default organization
    session[:oid] ||= 1

    @current_organization = Organization.find(session[:oid].to_i)
    if current_user
      current_user.current_organization = @current_organization
    end
  end

end
