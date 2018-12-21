class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  include DmUniboCommon::Controllers::Helpers

  impersonates :user

  before_action :log_current_user, :force_sso_user
  after_action :verify_authorized, except: [:index, :who_impersonate, :impersonate, :shibboleth]

  def current_organization
    # tmp TODO FIXME
    session[:oid] = 1 unless session[:oid]

    if session[:oid]
      @current_organization = Organization.find(session[:oid].to_i)
    else
      redirect_to choose_current_organization
    end
  end

  def check_user_can_admin
    current_user.is_admin?
  end
end
