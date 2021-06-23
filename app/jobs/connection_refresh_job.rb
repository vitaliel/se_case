class ConnectionRefreshJob < ApplicationJob
  queue_as :default

  def perform(params)
    User.transaction do
      user = User.where(external_id: params['customer_id']).first!
      conn = user.connections.where(external_id: params['connection_id']).first
      conn ||= create_connection(user, params['connection_id'])

      Accounts::Refresh.new(user, conn, gateway).call

      conn.accounts.each do |account|
        Transactions::Refresh.new(user, account, gateway).call
      end
    end
  end

  def create_connection(user, connection_id)
    item = gateway.connection_show(connection_id)
    conn = Connection.new(user: user, external_id: item['id'])
    conn.provider_code = item['provider_code']
    conn.provider_name = item['provider_name']
    conn.save!
    conn
  end
end
