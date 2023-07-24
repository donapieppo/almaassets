class ApplicationController < DmUniboCommon::ApplicationController
  before_action :set_current_user,
    :update_authorization,
    :set_current_organization,
    :after_current_user_and_organization,
    :log_current_user,
    :force_sso_user
  after_action :verify_authorized, except: [:who_impersonate, :impersonate, :shibboleth]

  def after_current_user_and_organization
  end
end
