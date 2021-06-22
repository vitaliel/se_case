class ConnectionsController < ApplicationController
  before_action :authenticate_user!

  def index
    Connections::Refresh.new(current_user, gateway).call
    @items = current_user.connections.order(:id).all
  end

  def add
    response = gateway.connect_session(current_user.external_id)
    @connect_url = response['connect_url']
  end
end
