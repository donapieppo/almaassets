class MainAgreementsController < ApplicationController
  before_action :set_main_agreement_and_check_permission, only: [:show, :edit, :update]

  def index
    @main_agreements = MainAgreement.order(:category_id, :price).includes(:category, :good_requests).all
    authorize :main_agreement
  end

  def new
    @main_agreement = MainAgreement.new
    authorize @main_agreement
  end

  def create
    @main_agreement = MainAgreement.new(main_agreement_params)
    authorize @main_agreement
    if @main_agreement.save
      redirect_to main_agreements_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @main_agreement.update_attributes(main_agreement_params)
      redirect_to main_agreements_path
    else
      render :edit
    end
  end

  private

  def main_agreement_params
    params[:main_agreement].permit(:category_id, :title, :name, :vendor_and_model, :description, :notes, :price)
  end

  def set_main_agreement_and_check_permission
    @main_agreement = MainAgreement.find(params[:id])
    authorize @main_agreement
  end
end

