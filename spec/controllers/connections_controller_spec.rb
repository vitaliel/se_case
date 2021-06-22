require 'rails_helper'

describe ConnectionsController do
  render_views

  login_user

  describe '#index' do
    before do
      @connection = create(:connection, user: @user)
    end

    it 'succeeds' do
      gateway = double
      expect(controller).to receive(:gateway).and_return(gateway)
      expect(gateway).to receive(:connections).and_return([])

      get :index, params: {}
      expect(response).to have_http_status(200)
      expect(assigns(:items)).to eq [@connection]
    end
  end
end
