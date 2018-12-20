class GoodsController < ApplicationController
  before_action :set_good_and_check_permission, only: [:show, :edit, :update, :destroy]

  def index
    @goods = Good.includes(:category, :user)

    if current_user.is_admin? and params[:unassigned]
      @goods = @goods.where(user_id: nil) if params[:unassigned]
      @title = 'Elenco beni non assegnati'
    end

    if current_user.is_admin? and params[:user_id]
      @user  = User.find(params[:user_id])
      @goods = @goods.where(user_id: @user.id)
      @title = "Elenco beni #{@user}"
    end

    if current_user.is_admin? and params[:category_id]
      @category = Category.find(params[:category_id])
      @goods = @goods.where(category_id: @category.id)
      @title = "Elenco beni tipo \"#{@category}\""
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
    @search_string = params[:search_string] || ''
    @title = "Ricerca per #{@search_string}"
    @goods = []
    if params[:search_string] =~ /\A[0-9]+\Z/
      @goods << Good.where(inv_number: @search_string.to_i).to_a
      @goods << Good.where(old_inv_number: @search_string.to_i).to_a
    elsif @search_string.size > 2
      sql_string = "%#{@search_string}%"
      @goods << Good.where("goods.description like ? or goods.unibo_description like ?", sql_string, sql_string).to_a
    end
    @goods.flatten!
    render action: :index
  end

  private

  def set_good_and_check_permission
    @good = Good.find(params[:id])
    authorize @good
  end

  def good_params
    if current_user.is_admin?
      params[:good].permit(:name, :description, :user_request, :user_justification, :category_id)
    else
      # category_id only if new
      params[:good].permit(:user_request, :user_justification, :category_id, :user_upn)
    end
  end
end
