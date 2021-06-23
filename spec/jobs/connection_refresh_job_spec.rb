require 'rails_helper'

describe ConnectionRefreshJob do
  let(:user) { create(:user) }
  let(:connection_id) { '2222222' }
  let(:account_id) { '333333' }

  it 'succeeds' do
    gateway = double
    expect(Gateway).to receive(:new).and_return(gateway)
    expect(gateway).to receive(:connection_show).with(connection_id).and_return(
      'id' => connection_id,
      'provider_code' => 'test_account',
      'provider_name' => 'Test Account'
    )
    expect(gateway).to receive(:accounts).with(connection_id).and_return(
      [
        { 'id' => account_id,
          'name' => 'Test account',
          'balance' => 135,
          'currency_code' => 'EUR',
          'nature' => 'card'
        }
      ]
    )
    expect(gateway).to receive(:transactions).with(
      connection_id,
      account_id
    ).and_return(
      [
        { 'id' => '4441',
          'status' => 'posted',
          'made_on' => '2021-06-06',
          'amount' => 135,
          'currency_code' => 'EUR',
          'category' => 'shopping',
          'description' => 'Big shirt'
        }
      ]
    )
    expect(gateway).to receive(:transactions_pending).with(
      connection_id,
      account_id
    ).and_return([])

    described_class.perform_now('customer_id' => user.external_id, 'connection_id' => connection_id)

    expect(user.connections.count).to eq 1
    conn = user.connections.first
    expect(conn.external_id).to eq connection_id
    expect(conn.accounts.count).to eq 1
    account = conn.accounts.first
    expect(account.external_id).to eq account_id
    expect(account.transactions.count).to eq 1
    txn = account.transactions.first
    expect(txn.external_id).to eq '4441'
  end
end
