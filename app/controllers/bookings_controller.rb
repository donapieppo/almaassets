class BookingsController < ApplicationController
  before_action :get_server, except: :destroy

  def index
    @bookings = {}
    @server.bookings.in_week.includes(:user).order(:start_at).each do |booking|
      @bookings[booking.start_at.to_date] ||=  {}
      @bookings[booking.start_at.to_date][booking.start_at.hour] = booking
    end
  end

  def new
    authorize(@booking)
  end

  def create
    @booking = @server.bookings.new(user: current_user)
    @booking.start_at = (Date.today + params[:d].to_i.day + params[:h].to_i.hour)
    authorize(@booking)
    if @booking.save
      redirect_to server_bookings_path(@server)
    else
      render :new
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy
    redirect_to server_bookings_path(@booking.server_id)
  end

  private

  def get_server
    @server = Server.find(params[:server_id]) if params[:server_id]
  end
end

