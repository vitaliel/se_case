class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    connection = current_user.connections.find(params[:connection_id])
    Accounts::Refresh.new(current_user, connection, gateway).call
    @items = current_user.accounts.where(connection_id: connection.id).order(:id).all
  end
end
