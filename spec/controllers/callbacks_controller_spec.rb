require 'rails_helper'

describe CallbacksController do
  describe 'POST /success' do
    let(:customer_id) { '1111' }
    let(:connection_id) { '2222-ola' }

    it 'succeeds' do
      expect(ConnectionRefreshJob).to receive(:perform_later).with(
        { 'connection_id' => connection_id, 'customer_id' => customer_id }
      )
      post :success, params: { data: { connection_id: connection_id, customer_id: customer_id } }
      expect(response).to have_http_status(:ok)
    end
  end
end
