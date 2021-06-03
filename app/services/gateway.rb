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
end
