class DocumentsController < ApplicationController
  before_action :get_what_and_check_permission, only: [:new, :create]
  before_action :get_document_and_check_permission, only: [:edit, :update, :destroy]

  def new
    @document = @what.documents.new
  end

  def create
    @document = @what.documents.new(document_params)

    if !@document.attach.attached? 
      flash[:error] = "Non è stato allegato il file."
    elsif @document.save
      flash[:notice] = "L'allegato è stato salvato."
    else
      flash[:error] = "Non è stato possibile salvare l'allegato. #{@document.errors.first.inspect}."
    end

    redirect_to [:edit, @what]
  end

  def edit
  end

  def update
    if @document.update(document_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @document.destroy
  end

  private 

  def document_params
    params[:document].permit(:name, :attach)
  end

  def get_what_and_check_permission
    if params[:main_agreement_id]
      @what = MainAgreement.find(params[:main_agreement_id])
    end
    authorize @what, :edit
  end

  def get_document_and_check_permission
    @document = Document.find(params[:id])
    authorize @document
  end
end

