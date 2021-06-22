module Transactions
  class Refresh
    attr_accessor :user, :account, :gateway

    def initialize(user, account, gateway)
      self.user = user
      self.account = account
      self.gateway = gateway
    end

    def call
      items = []

      begin
        items = gateway.transactions(account.connection.external_id, account.external_id)
      rescue StandardError => e
        Rails.logger.error e
      end

      items.each do |item|
        txn = Transaction.where(external_id: item['id']).first
        txn ||= Transaction.new(account: account, external_id: item['id'])
        txn.status = item['status']
        txn.made_on = item['made_on']
        txn.amount = item['amount']
        txn.currency_code = item['currency_code']
        txn.category = item['category']
        txn.description = item['description']
        txn.save!
      end
    end
  end
end
