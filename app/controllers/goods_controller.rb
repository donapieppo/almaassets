class GoodsController < ApplicationController
  before_action :set_good, only: [:show, :edit, :update, :destroy]

  def index
    @goods = Good.includes(:cathegory).all
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

  private

  def set_good
    @good = Good.find(params[:id])
  end

  def good_params
    params[:good].permit(:name, :description, :cathegory_id)
  end
end
