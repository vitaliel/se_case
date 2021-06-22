require 'rails_helper'

describe Accounts::Refresh do
  let(:user) { create(:user) }
  let(:connection) { create(:connection, user: user) }

  describe '#call' do
    it 'succeeds' do
      data = [
        { 'id' => '3331', 'name' => 'Test account', 'balance' => 135, 'currency_code' => 'EUR', 'nature' => 'card' }
      ]
      gateway = double
      expect(gateway).to receive(:accounts).with(connection.external_id).and_return(data)
      described_class.new(user, connection, gateway).call
      expect(user.accounts.count).to eq 1
      account = user.accounts.first
      hash = data.first
      expect(account.external_id).to eq hash['id']
      expect(account.name).to eq hash['name']
      expect(account.balance).to eq hash['balance']
      expect(account.currency_code).to eq hash['currency_code']
      expect(account.nature).to eq hash['nature']
    end
  end
end
