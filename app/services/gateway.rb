require 'saltedge'

class Gateway
  BASE_URI = 'https://www.saltedge.com/api/v5'

  def initialize(api = nil)
    @api = api || Saltedge.new(
      ENV.fetch("SE_APP_ID"),
      ENV.fetch("SE_SECRET"),
      ENV.fetch("SE_PRV_PEM_PATH"),
    )
  end

  def customer_register(customer_id)
    raise ArgumentError if customer_id.blank?

    response = @api.request(:post, "#{BASE_URI}/customers/", { "data" => { "identifier" => customer_id.to_s } })
    result = JSON.parse(response.body)
    result['data']
  end

  # @return Hash
  # connect_url, expires_at
  def connect_session(customer_id)
    raise ArgumentError if customer_id.blank?

    data = { 'data' => {
      'customer_id' => customer_id,
      'consent' => {
        'scopes' => %w[account_details transactions_details],
        'from_date' => '2021-01-01'
      }
    }}
    response = @api.request(:post, "#{BASE_URI}/connect_sessions/create", data)
    result = JSON.parse(response.body)
    result['data']
  end

  def connections(customer_id)
    raise ArgumentError if customer_id.blank?

    response = @api.request(:get, "#{BASE_URI}/connections?customer_id=#{customer_id}")
    result = JSON.parse(response.body)
    p result if Rails.env.development?
    result['data']
  end

  def accounts(connection_id)
    raise ArgumentError if connection_id.blank?

    response = @api.request(:get, "#{BASE_URI}/accounts?connection_id=#{connection_id}")
    result = JSON.parse(response.body)
    p result if Rails.env.development?
    result['data']
  end

  def transactions(connection_id, account_id)
    raise ArgumentError if connection_id.blank? || account_id.blank?
    response = @api.request(:get, "#{BASE_URI}/transactions?connection_id=#{connection_id}&account_id=#{account_id}")
    result = JSON.parse(response.body)
    p result if Rails.env.development?
    result['data']
  end
end
