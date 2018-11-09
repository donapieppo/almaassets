class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  include DmUniboCommon::Controllers::Helpers

  impersonates :user

  before_action :log_current_user, :force_sso_user
end
