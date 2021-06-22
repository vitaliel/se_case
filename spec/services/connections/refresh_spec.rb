require 'rails_helper'

describe Connections::Refresh do
  let(:user) { create(:user) }

  describe '#call' do
    it 'succeeds' do
      data = [
        { 'id' => '1111', 'provider_code' => 'test_account', 'provider_name' => 'Test Account' }
      ]
      gateway = double
      expect(gateway).to receive(:connections).with(user.external_id).and_return(data)
      described_class.new(user, gateway).call
      expect(user.connections.count).to eq 1
      conn = user.connections.first
      hash = data.first
      expect(conn.external_id).to eq hash['id']
      expect(conn.provider_code).to eq hash['provider_code']
      expect(conn.provider_name).to eq hash['provider_name']
    end
  end
end
