class ApplicationController < DmUniboCommon::ApplicationController
  before_action :set_current_user, :update_authorization, :set_current_organization, :log_current_user, :force_sso_user
  after_action :verify_authorized, except: [:index, :who_impersonate, :impersonate, :shibboleth]
end
