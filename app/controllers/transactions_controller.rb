class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @account = current_user.accounts.find(params[:account_id])
    Transactions::Refresh.new(current_user, @account, gateway).call
    @items = Transaction.where(account_id: @account.id).order(:id).all
  end
end
