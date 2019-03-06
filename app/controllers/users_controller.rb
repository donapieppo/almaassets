class UsersController < ApplicationController
  before_action :check_user_can_admin

  def index
    @users = User.order(:surname, :name)
    render layout: false
  end

  def new
    authorize User.new
  end

  def create
    if r = /\A(\w+\.\w+)(@unibo.it)?\z/.match(params[:upn])
      upn = r[1] + '@unibo.it'
      begin
        user = User.syncronize(upn)
        user.update_attribute(:organization_id, current_organization.id)
        authorize user
      rescue DmUniboCommon::NoUser
        flash[:alert] = "Non esiste l'utente selezionato nel database di Ateneo."
      end
    end
    redirect_to new_user_path
  end
end
