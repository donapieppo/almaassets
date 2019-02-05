class GoodsController < ApplicationController
  before_action :set_good_and_check_permission, only: [:show, :edit, :update, :unload, :new_confirm, :confirm, :new_unconfirm, :unconfirm, :ask_category, :set_category]

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
        @title = "Elenco beni presso \"#{@location}\""
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

  # def new 
  #   @category = Category.find(params[:category_id])
  #   @good = @category.goods.new
  # end

  # def create
  #   @category = Category.find(params[:category_id])
  #   @good = @category.goods.new(good_params)
  #   @good.user = current_user
  #   if @good.save
  #     redirect_to goods_path, notice: "La richiesta è stata creato correttamente."
  #   else
  #     render action: :new
  #   end
  # end

  def edit
    render layout: false if modal_page
  end

  def update
    manage_confirmed_param
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
    @good.confirm_presence(current_user)
    redirect_to goods_path
  end

  def new_unconfirm
  end

  def unconfirm
    # TODO
    redirect_to goods_path
  end

  def ask_category
    render layout: false
  end

  def set_category
    @good.update_attribute(:category_id, params[:category_id])
    @good.reload
  end

  def print
    authorize Good
    @goods = Good.where(to_unload: true).select(:inv_number, :unibo_description).to_a
    respond_to do |format|
      format.html { render layout: false }
      format.csv { send_data @goods.map{|x| [x.inv_number, x.unibo_description].to_csv}.join, 
                   filename: "Richiesta_scarichi_#{I18n.l Date.today}_#{current_organization.name}.csv" }
    end
  end

  private

  def set_good_and_check_permission
    @good = Good.find(params[:id])
    authorize @good
  end

  # FIXME how to unconfirm
  def manage_confirmed_param
    # confirmed in database is datetime and in form is just bool
    if current_user.is_admin? 
      if params[:good].delete(:confirmed) == "1"
        @good.confirm_presence(current_user)
      end
    end
  end

  def good_params
    if current_user.is_admin?
      params[:good].permit(:name, :description, :user_request, :user_justification, :category_id, :user_upn, :location_id, :confirmed, :admin_notes)
    else
      # category_id only if new
      params[:good].permit(:user_request, :user_justification, :category_id)
    end
  end
end
