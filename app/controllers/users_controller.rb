class UsersController < ApplicationController
  before_action :check_user_can_admin

  def index
    @users = User.order(:surname, :name)
    render layout: false
  end
end
