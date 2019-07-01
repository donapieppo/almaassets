class ServersController < ApplicationController
  before_action :get_server, only: [:edit, :update, :destroy]

  def index
    @servers = current_organization.servers
  end

  def new
    @server = current_organization.servers.new
  end

  def create
    @server = current_organization.servers.new(server_params)
    authorize @server
    if @server.save
      redirect_to servers_path, notice: 'ok'
    else
      render action: :new
    end
  end

  def edit
    authorize @server
  end

  def update
    authorize @server
    if @server.update_attributes(server_params)
      redirect_to servers_path, notice: 'ok'
    else
      render action: :edit
    end
  end

  def destroy
    authorize @server
  end

  private

  def server_params
    params[:server].permit(:name, :url, :hardware, :software)
  end

  def get_server
    @server = Server.find(params[:id])
  end

end
