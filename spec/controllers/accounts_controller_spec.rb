require 'rails_helper'

describe AccountsController do
  render_views

  login_user

  let(:connection) { create(:connection, user: @user) }

  describe '#index' do
    before do
      @account = create(:account, connection: connection, user: @user)
    end

    it 'succeeds' do
      gateway = double
      expect(controller).to receive(:gateway).and_return(gateway)
      expect(gateway).to receive(:accounts).and_return([])

      get :index, params: { connection_id: connection.id }
      expect(response).to have_http_status(200)
      expect(assigns(:items)).to eq [@account]
    end
  end
end
