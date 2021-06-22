require 'rails_helper'

describe Gateway do
  let(:base_uri) { Gateway::BASE_URI }
  let(:api) { double }
  describe '#customer_register' do
    let(:email) { 'dev@dev.dev' }
    it 'succeeds' do
      expect(api).to receive(:request).with(
        :post,
        "#{base_uri}/customers/",
        { "data" => { "identifier" => email } }
      ).and_return(
        OpenStruct.new(body: JSON.dump('data' => { 'id' => '11111' }))
      )
      result = described_class.new(api).customer_register(email)
      expect(result).to eq('id' => '11111')
    end
  end

  describe '#connect_session' do
    it 'succeeds' do
      customer_id = '11111'
      expect(api).to receive(:request).with(
        :post,
        "#{base_uri}/connect_sessions/create",
        { 'data' => {
          'customer_id' => customer_id,
          'consent' => {
            'scopes' => %w[account_details transactions_details],
            'from_date' => '2021-01-01'
          }
        } }
      ).and_return(
        OpenStruct.new(body: JSON.dump('data' => { 'connect_url' => 'https://dev.io/connect' }))
      )
      result = described_class.new(api).connect_session(customer_id)
      expect(result).to eq({ 'connect_url' => 'https://dev.io/connect' })
    end
  end

  describe '#connections' do
    it 'succeeds' do
      customer_id = '11111'
      expect(api).to receive(:request).with(
        :get,
        "#{base_uri}/connections?customer_id=#{customer_id}",
      ).and_return(
        OpenStruct.new(body: JSON.dump('data' => [{ 'id' => '22222' }]))
      )
      result = described_class.new(api).connections(customer_id)
      expect(result).to eq([{ 'id' => '22222' }])
    end
  end

  describe '#accounts' do
    it 'succeeds' do
      connection_id = '11111'
      expect(api).to receive(:request).with(
        :get,
        "#{base_uri}/accounts?connection_id=#{connection_id}",
      ).and_return(
        OpenStruct.new(body: JSON.dump('data' => [{ 'id' => '22222' }]))
      )
      result = described_class.new(api).accounts(connection_id)
      expect(result).to eq([{ 'id' => '22222' }])
    end
  end

  describe '#transactions' do
    it 'succeeds' do
      connection_id = '11111'
      account_id = '22222'
      expect(api).to receive(:request).with(
        :get,
        "#{base_uri}/transactions?connection_id=#{connection_id}&account_id=#{account_id}",
      ).and_return(
        OpenStruct.new(body: JSON.dump('data' => [{ 'id' => '22222' }]))
      )
      result = described_class.new(api).transactions(connection_id, account_id)
      expect(result).to eq([{ 'id' => '22222' }])
    end
  end
end
