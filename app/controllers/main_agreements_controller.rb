class MainAgreementsController < ApplicationController
  before_action :set_main_agreement_and_check_permission, only: [:show, :edit, :update, :destroy]

  def index
    @main_agreements = current_organization.main_agreements.order(:category_id, :price).includes(:category, :good_requests).all
    authorize :main_agreement
  end

  def new
    @main_agreement = current_organization.main_agreements.new
    authorize @main_agreement
  end

  def create
    @main_agreement = current_organization.main_agreements.new(main_agreement_params)
    authorize @main_agreement
    if @main_agreement.save
      redirect_to main_agreements_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @main_agreement.update(main_agreement_params)
      redirect_to main_agreements_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @good_requests = @main_agreement.good_requests.all
    if @good_requests.any?
      redirect_to good_requests_path
    else
      @main_agreement.destroy
      redirect_to main_agreements_path
    end
  end

  private

  def main_agreement_params
    params[:main_agreement].permit(:category_id, :title, :name, :vendor_and_model, :description, :notes, :price, :document)
  end

  def set_main_agreement_and_check_permission
    @main_agreement = MainAgreement.find(params[:id])
    authorize @main_agreement
  end
end

