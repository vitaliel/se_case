module Accounts
  class Refresh
    attr_accessor :user, :connection, :gateway

    def initialize(user, connection, gateway)
      self.user = user
      self.connection = connection
      self.gateway = gateway
    end

    def call
      items = []

      begin
        items = gateway.accounts(connection.external_id)
      rescue StandardError => e
        Rails.logger.error e
      end

      items.each do |item|
        account = Account.where(external_id: item['id']).first
        account ||= Account.new(user: user, connection: connection, external_id: item['id'])
        account.name = item['name']
        account.nature = item['nature']
        account.balance = item['balance']
        account.currency_code = item['currency_code']
        account.save!
      end
    end
  end
end
