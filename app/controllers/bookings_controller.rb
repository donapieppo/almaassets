class BookingsController < ApplicationController
  skip_before_action :force_sso_user, only: :hg
  before_action :get_server, except: :destroy

  def index
    @bookings = {}
    @server.bookings.in_week.includes(:user).order(:start_at).each do |booking|
      @bookings[booking.start_at.to_date] ||=  {}
      @bookings[booking.start_at.to_date][booking.start_at.hour] = booking
    end
  end

  def create
    @d = params[:d].to_i
    @h = params[:h].to_i
    @booking = @server.bookings.new(user: current_user)
    @booking.start_at = (Date.today + @d.day + @h.hour)
    authorize(@booking)
    if ! @booking.save
      flash[:alert] = "Non è stato possibile prenotare."
    end
    respond_to do |format|
      format.html { redirect_to server_bookings_path(@server) }
      format.js {}
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy
    redirect_to server_bookings_path(@booking.server_id)
  end

  # hidden get
  def hg
    authorize(:booking)
    @server = Server.get_by_api_key(params[:id])
    respond_to do |format|
      format.json { render json: @server ? client_json(@server.bookings.includes(:user).order(:start_at).today) : [] }
    end
  end

  private

  def get_server
    @server = Server.find(params[:server_id]) if params[:server_id]
  end

  def client_json(boorkings)
    boorkings.map do |b|
      {
        user: b.user.cn, 
        email: b.user.upn, 
        start_at: I18n.l(b.start_at)
      }
    end
  end

end

