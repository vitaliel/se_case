require 'saltedge'

class Gateway
  BASE_URI = 'https://www.saltedge.com/api/v5'

  def initialize
    @api = Saltedge.new(
      ENV.fetch("SE_APP_ID"),
      ENV.fetch("SE_SECRET"),
      ENV.fetch("SE_PRV_PEM_PATH"),
    )
  end

  def countries
    response = @api.request(:get, "#{BASE_URI}/countries")
    result = JSON.parse(response.body)
    result['data']
  end

  def customer_register(customer_id)
    raise ArgumentError if customer_id.blank?

    response = @api.request(:post, "#{BASE_URI}/customers/", { "data" => { "identifier" => customer_id.to_s } })
    result = JSON.parse(response.body)
    result['data']
  end

  def connect_session(customer_external_id)
    raise ArgumentError if customer_id.blank?

    data = { 'data' => {
      'customer_id' => customer_external_id,
      'consent' => {
        'scopes' => %w[account_details transactions_details],
        'from_date' => '2019-01-01'
      }
    }}
    response = @api.request(:post, "#{BASE_URI}/customers/", data)
    result = JSON.parse(response.body)
    result['data']
  end
end
