class GoodsController < ApplicationController
  before_action :set_good, only: [:show, :edit, :update, :destroy]

  def index
    @goods = Good.includes(:cathegory, :user)
    @goods = @goods.where(user_id: nil) if params[:unassigned]
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
  end

  private

  def set_good
    @good = Good.find(params[:id])
  end

  def good_params
    params[:good].permit(:user_request, :user_justification, :cathegory_id)
  end
end
