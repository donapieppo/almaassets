class GoodRequestsController < ApplicationController
  before_action :set_good_request_and_check_permission, only: [:show, :edit, :update, :print, :destroy, :edit_approve, :approve]

  def index
    if policy(current_organization).manage?
      @good_requests = GoodRequest
    else
      @good_requests = current_user.good_requests
    end
    @good_requests = @good_requests.order('users.surname, users.name, category_id').includes(:category, :user)
    authorize :good_request
  end

  def new 
    @good_request = current_user.good_requests.new(organization: current_organization)

    if params[:category_id]
      @good_request.category = Category.find(params[:category_id])
      @available_agreements = @good_request.category.main_agreements.all 
    end

    if params[:main_agreement_id]
      @good_request.main_agreement = MainAgreement.find(params[:main_agreement_id]) 
      @good_request.name = @good_request.main_agreement.vendor_and_model
    end

    @good_request.outside_agreements = params[:outside_agreements]

    # se in convenzione o ha scelto fuori convenzione o se nella cateoria non ci sono convenzioni
    @can_ask = @good_request.main_agreement || @good_request.outside_agreements || (@good_request.category && @available_agreements.empty?) 

    authorize @good_request
  end

  def create
    @category = Category.find(params[:category_id])
    @good_request = @category.good_requests.new(good_request_params)

    @good_request.user = current_user unless policy(current_organization).manage?
    @good_request.organization = current_organization unless policy(current_organization).manage?

    authorize @good_request
    if @good_request.save
      redirect_to root_path, notice: "La richiesta è stata creato correttamente."
    else
      render action: :new, status: :unprocessable_entity
    end
  end

  def edit
    @good_request.outside_agreements = (! @good_request.main_agreement_id and @good_request.category.main_agreements.any?)
  end

  def update
    if @good_request.update(good_request_params)
      redirect_to root_path, notice: 'La richiesta è stata aggiornata.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def print
    filename = params[:man] ? 'manifestazione_esigenza_' : 'relazione_rup_'
    filename += @good_request.user.cn.gsub(' ', '_') + '.docx'
    respond_to do |format|
      format.docx do
        headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
        if params[:man]
          render 'good_requests/print_manifestazione'
        end
      end
    end
  end

  def destroy
    @good_request.destroy
    redirect_to root_path
  end

  def approve
    @good_request.holder_approve!
    redirect_to root_path
  end

  private

  def set_good_request_and_check_permission
    @good_request = GoodRequest.find(params[:id])
    authorize @good_request
  end

  def good_request_params
    p = [:category_id, :main_agreement_id, :holder_id, :name, :description, :teach_description, :derogation, :max_price]
    (p << :user_id) if policy(current_organization).manage?
    params[:good_request].permit(p)
  end
end
