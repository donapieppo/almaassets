class GoodsController < ApplicationController
  before_action :set_good_and_check_permission, only: [:show, :edit, :update, :unload, :new_confirm, :confirm, :new_unconfirm, :unconfirm]

  def index
    @goods = Good.includes(:category, :user, :location)

    if current_user.is_admin? 
      if params[:unassigned]
        @goods = @goods.where(user_id: nil) 
        @title = 'Elenco beni non assegnati'
      elsif params[:no_category]
        @goods = @goods.where(category_id: nil).order(:description)
        @title = 'Elenco beni senza categoria'
      elsif  params[:user_id]
        @user  = User.find(params[:user_id])
        @goods = @goods.where(user_id: @user.id)
        @title = "Elenco beni #{@user}"
      elsif params[:category_id]
        @category = Category.find(params[:category_id])
        @goods = @goods.where(category_id: @category.id)
        @title = "Elenco beni tipo \"#{@category}\""
        @no_icon = true
      elsif params[:location_id]
        @location = Location.find(params[:location_id])
        @goods = @goods.where(location_id: @location.id)
        @title = "Elenco beni tipo \"#{@location}\""
      elsif params[:unload]
        @goods = @goods.where(to_unload: true)
        @title = "Elenco beni da disinventariare"
      else
        @goods = @goods.where(user_id: nil)
        @title = 'Elenco beni non assegnati'
      end
    else
      @title = 'Elenco beni a lei assegnati'
      @goods = @goods.where(user_id: current_user.id).where(to_unload: nil)
    end
  end

  def new 
    @category = Category.find(params[:category_id])
    @good = @category.goods.new
  end

  def create
    @category = Category.find(params[:category_id])
    @good = @category.goods.new(good_params)
    @good.user = current_user
    if @good.save
      redirect_to goods_path, notice: "La richiesta è stata creato correttamente."
    else
      render action: :new
    end
  end

  def edit
    render layout: false if modal_page
  end

  def update
    if @good.update_attributes(good_params)
      redirect_to good_path(@good), notice: "Aggiornamento registrato correttamente."
    else
      render action: :show
    end
  end

  def find
    authorize(:good)
    @search_string = params[:search_string] || ''
    @title = "Ricerca per #{@search_string}"

    @goods = []

    # first by inv num
    if @search_string =~ /\A[0-9]+\Z/
      @goods << Good.where(inv_number: @search_string.to_i).to_a
      @goods << Good.where(old_inv_number: @search_string.to_i).to_a
    end
    if @search_string.size > 2
      sql_string = "%#{@search_string}%"
      @goods << Good.where("goods.description like ? or goods.unibo_description like ?", sql_string, sql_string).to_a
    end

    @goods.flatten!
    render action: :index
  end

  def unload
    @good.update_attribute(:to_unload, ! @good.to_unload)
    # @to_unload = @good.reload.to_unload
  end

  def new_confirm
  end

  # only simple users
  def confirm
  end

  def new_unconfirm
  end

  def unconfirm
  end

  private

  def set_good_and_check_permission
    @good = Good.find(params[:id])
    authorize @good
  end

  def good_params
    # confirmed in database is datetime and in form is just bool
    if params[:good][:confirmed] == "1"
      params[:good][:confirmed] = Time.now
    end
    if current_user.is_admin?
      params[:good].permit(:name, :description, :user_request, :user_justification, :category_id, :user_upn, :location_id, :confirmed, :admin_notes)
    else
      # category_id only if new
      params[:good].permit(:user_request, :user_justification, :category_id)
    end
  end
end
