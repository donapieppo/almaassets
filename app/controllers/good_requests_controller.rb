class GoodRequestsController < ApplicationController
  before_action :set_good_request_and_check_permission, only: [:show, :edit, :update]

  def index
    @good_requests = current_user.good_requests
  end

  def new 
    @category = Category.find(params[:category_id])
    @available_agreements = @category.main_agreements.all

    if params[:main_agreement_id]
      @main_agreement = MainAgreement.find(params[:main_agreement_id]) 
    elsif params[:outside_agreements]
      @outside_agreements = true
    end
    @good_request = @category.good_requests.new
    authorize @good_request
  end

  def create
    @category = Category.find(params[:category_id])
    @good_request = @category.good_requests.new(good_request_params)
    @good_request.user = current_user
    authorize @good_request
    if @good_request.save
      redirect_to goods_path, notice: "La richiesta è stata creato correttamente."
    else
      render action: :new
    end
  end

  private

  def set_good_request_and_check_permission
    @good_request = GoodRequest.find(params[:id])
    authorize @good_request
  end

  def good_request_params
    params[:good_request].permit(:category_id, :main_agreement_id, :name, :description, :derogation)
  end
end
