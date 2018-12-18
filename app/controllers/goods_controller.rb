class GoodsController < ApplicationController
  before_action :set_good, only: [:show, :edit, :update, :destroy]

  def index
    @goods = Good.includes(:cathegory, :user)

    if current_user.is_admin? and params[:unassigned]
      @goods = @goods.where(user_id: nil) if params[:unassigned]
      @title = 'Elenco beni non assegnati'
    end

    if current_user.is_admin? and params[:user_id]
      @user  = User.find(params[:user_id])
      @goods = @goods.where(user_id: @user.id)
      @title = "Elenco beni #{@user}"
    end

    if current_user.is_admin? and params[:cathegory_id]
      @cathegory = Cathegory.find(params[:cathegory_id])
      @goods = @goods.where(cathegory_id: @cathegory.id)
      @title = "Elenco beni tipo \"#{@cathegory}\""
    end

    if current_user.is_admin? and params[:location_id]
      @location = Location.find(params[:location_id])
      @goods = @goods.where(location_id: @location.id)
      @title = "Elenco beni tipo \"#{@location}\""
    end

    if ! current_user.is_admin?
      @goods = @goods.where(user_id: current_user.id)
    end
  end

  def new 
    @cathegory = Cathegory.find(params[:cathegory_id])
    @good = @cathegory.goods.new
  end

  def create
    @cathegory = Cathegory.find(params[:cathegory_id])
    @good = @cathegory.goods.new(good_params)
    @good.user = current_user
    if @good.save
      redirect_to goods_path, notice: "La richiesta è stata creato correttamente."
    else
      render action: :new
    end
  end

  def edit
    render layout: false
  end

  def update
    if @good.update_attributes(good_params)
      redirect_to edit_good_path(@good), notice: "Aggiornamento registrato correttamente."
    else
      render action: :edit
    end
  end

  private

  def set_good
    @good = Good.find(params[:id])
  end

  def good_params
    if current_user.is_admin?
      params[:good].permit(:user_request, :user_justification, :cathegory_id, :user_upn)
    else
      # cathegory_id only if new
      params[:good].permit(:user_request, :user_justification, :cathegory_id)
    end
  end
end
