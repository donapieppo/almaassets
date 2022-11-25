class GoodsController < ApplicationController
  before_action :set_good_and_check_permission, only: [:show, :edit, :update, :new_unload, :unload, :new_confirm, :confirm, :new_unconfirm, :unconfirm, :ask_category, :set_category]

  def index
    @goods = current_organization.goods.includes(:category, :user, :location)

    if policy(current_organization).read? 
      if params[:unassigned]
        @goods = @goods.where(user_id: nil) 
        @title = 'Elenco beni non assegnati'
      elsif params[:unconfirmed]
        @goods = @goods.where.not(unconfirmed: nil) 
        @title = 'Elenco beni dichiarati non posseduti.'
        elsif params[:no_category]
        @goods = @goods.where(category_id: nil).order(:description)
        @title = 'Elenco beni senza categoria'
      elsif params[:user_id]
        @user  = User.find(params[:user_id])
        @goods = @goods.where(user_id: @user.id)
        @title = "Elenco beni #{@user}"
      elsif params[:category_id]
        @category = Category.find(params[:category_id])
        @goods = @goods.where(category_id: @category.id)
        @title = "Elenco beni tipo \"#{@category}\""
        @no_icon = true
      elsif params[:location_id] && params[:location_id] != '0'
        @location = Location.find(params[:location_id])
        @goods = @goods.where(location_id: @location.id)
        @title = "Elenco beni presso \"#{@location}\""
      elsif params[:location_id] == "0"
        @goods = @goods.where(location_id: nil)
        @title = "Elenco beni senza ubicazione"
      elsif params[:unload]
        @goods = @goods.where(to_unload: true).order(:build_year)
        @title = "Elenco beni da disinventariare"
      elsif params[:newer]
        @goods = @goods.where("created_at > ?", params[:newer].to_i.days.ago)
        @title = "Elenco ultimi inserimenti"
      else
        @goods = @goods.where(user_id: nil)
        @title = 'Elenco beni non assegnati'
      end
    else
      @title = 'Elenco beni a lei assegnati'
      @goods = @goods.where(user_id: current_user.id).where(to_unload: nil)
    end
    authorize :good
  end

  def edit
  end

  def update
    manage_confirmed_param
    if @good.update(good_params)
      # redirect_to good_path(@good), notice: "Aggiornamento registrato correttamente."
    else
      render action: :show, status: :unprocessable_entity
    end
  end

  def find
    authorize current_organization, :read?
    @search_string = params[:search_string] || ''
    @title = "Ricerca per #{@search_string}"

    @goods = []

    # first by inv num
    if @search_string =~ /\A[0-9]+\Z/
      @goods << current_organization.goods.where(inv_number: @search_string.to_i).to_a
      @goods << current_organization.goods.where(old_inv_number: @search_string.to_i).to_a
    end
    if @search_string.size > 2
      sql_string = "%#{@search_string}%"
      @goods << current_organization.goods.where("goods.description like ? or goods.unibo_description like ? or goods.sn like ?", sql_string, sql_string, sql_string).to_a
    end

    @goods.flatten!
    render action: :index
  end

  def new_unload
  end

  def unload
    if @good.to_unload
      @good.update(to_unload: false, to_unload_status: nil)
    else
      @good.update(to_unload: true, to_unload_status: params[:good][:to_unload_status])
    end
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
    @good.unconfirm_presence(params[:unconfirm][:motivation])
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
    authorize :good
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
    if policy(@good).confirm?
      if params[:good].delete(:confirmed) == "1"
        @good.confirm_presence(current_user)
      end
    end
  end

  def good_params
    params[:good].permit(:name, :description, :user_request, :category_id, :user_upn, :location_id, :confirmed, :admin_notes, :to_unload_status)
  end
end
