class UsersController < ApplicationController
  def index
    @users = current_organization.goods.includes(:user).group(:user_id).where('user_id is not null').order('users.surname, users.name').map(&:user)
    authorize current_organization, :manage?
  end

  def new
    authorize current_organization, :manage?
  end

  def create
    authorize current_organization, :manage?
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
