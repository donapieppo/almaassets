class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Pundit

  include DmUniboCommon::Controllers::Helpers

  impersonates :user

  before_action :log_current_user, :force_sso_user, :set_organization, :update_current_user_authlevels
  after_action :verify_authorized, except: [:index, :who_impersonate, :impersonate, :shibboleth]

  def default_url_options(_options={})
    _options[:__org__] = current_organization ? current_organization.code : nil
    _options
  end
end
