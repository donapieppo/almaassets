class LocationsController < ApplicationController
  before_action :check_user_can_admin
  before_action :get_location_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @locations = Location.order(:name)
  end

  # def new
  #   @location = current_organization.locations.new
  #   render layout: false if modal_page
  # end

  # def create
  #   @location = current_organization.locations.new(location_params)
  #   if @location.save 
  #     redirect_to locations_path, notice: "L'ubicazione è stata creata."
  #   else
  #     render :new
  #   end
  # end

  # def edit
  #   render layout: false if modal_page
  # end

  # def update
  #   if @location.update_attributes(location_params) 
  #     redirect_to locations_path, notice: "L'ubicazione è stata modificata."
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   if @location.destroy
  #     flash[:notice] = "L'ubicazione è stata cancellata"
  #   else
  #     # FIXME
  #     flash[:error] = @location.errors[:base].first
  #   end
  #   redirect_to locations_path
  # end

  private

  def get_location_and_check_permission
    @location = Location.find(params[:id])
  end

  # can not choose organization_id
  def location_params
    params.require(:location).permit(:name)
  end

end


