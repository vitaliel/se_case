require 'rails_helper'

describe TransactionsController do
  render_views

  login_user

  let(:connection) { create(:connection, user: @user) }
  let(:account) { create(:account, connection: connection, user: @user) }

  describe '#index' do
    before do
      @txn = create(:transaction, account: account)
    end

    it 'succeeds' do
      gateway = double
      expect(controller).to receive(:gateway).and_return(gateway)
      expect(gateway).to receive(:transactions).and_return([])
      expect(gateway).to receive(:transactions_pending).and_return([])

      get :index, params: { account_id: account.id }
      expect(response).to have_http_status(200)
      expect(assigns(:items)).to eq [@txn]
    end
  end
end
