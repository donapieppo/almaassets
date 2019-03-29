class GoodRequestsController < ApplicationController
  before_action :set_good_request_and_check_permission, only: [:show, :edit, :update]

  def index
    @good_requests = GoodRequest.order('users.surname, users.name, category_id').includes(:category, :user)
    @good_requests = @good_requests.where(user: current_user) unless current_user.is_admin?
    authorize :good_request
  end

  def new 
    @good_request = GoodRequest.new

    @good_request.category = Category.find(params[:category_id]) if params[:category_id]
    @good_request.main_agreement = MainAgreement.find(params[:main_agreement_id]) if params[:main_agreement_id]
    @outside_agreements = params[:outside_agreements]

    if @good_request.category
      @available_agreements = @good_request.category.main_agreements.all 
    end

    authorize @good_request
  end

  def create
    @category = Category.find(params[:category_id])
    @good_request = @category.good_requests.new(good_request_params)
    @good_request.user = current_user unless user_admin?
    authorize @good_request
    if @good_request.save
      redirect_to root_path, notice: "La richiesta è stata creato correttamente."
    else
      render action: :new
    end
  end

  def edit
    @main_agreement = @good_request.main_agreement
  end

  def update
    if @good_request.update_attributes(good_request_params)
      redirect_to edit_good_request(@good_request) and return
    else
      render :edit
    end
  end

  private

  def set_good_request_and_check_permission
    @good_request = GoodRequest.find(params[:id])
    authorize @good_request
  end

  def good_request_params
    p = [:category_id, :main_agreement_id, :holder_id, :name, :description, :derogation, :max_price]
    (p << :user_id) if user_admin?
    params[:good_request].permit(p)
  end
end
