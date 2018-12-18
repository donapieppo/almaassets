class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  include DmUniboCommon::Controllers::Helpers

  impersonates :user

  before_action :log_current_user, :force_sso_user

  def current_organization
    @current_organization ||= Organization.first
    @current_organization
  end

  def check_user_can_admin
    current_user.is_admin?
  end
end
