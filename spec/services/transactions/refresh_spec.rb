require 'rails_helper'

describe Transactions::Refresh do
  let(:user) { create(:user) }
  let(:connection) { create(:connection, user: user) }
  let(:account) { create(:account, user: user, connection: connection) }

  describe '#call' do
    it 'succeeds' do
      data = [
        { 'id' => '4441',
          'status' => 'posted',
          'made_on' => '2021-06-06',
          'amount' => 135,
          'currency_code' => 'EUR',
          'category' => 'shopping',
          'description' => 'Big shirt'
        }
      ]
      gateway = double
      expect(gateway).to receive(:transactions).with(
        connection.external_id,
        account.external_id
      ).and_return(data)
      expect(gateway).to receive(:transactions_pending).with(
        connection.external_id,
        account.external_id
      ).and_return([])
      described_class.new(user, account, gateway).call
      expect(account.transactions.count).to eq 1
      txn = account.transactions.first
      hash = data.first
      expect(txn.external_id).to eq hash['id']
      expect(txn.status).to eq hash['status']
      expect(txn.made_on.to_s(:db)).to eq hash['made_on']
      expect(txn.amount).to eq hash['amount']
      expect(txn.currency_code).to eq hash['currency_code']
      expect(txn.category).to eq hash['category']
      expect(txn.description).to eq hash['description']
    end
  end
end
