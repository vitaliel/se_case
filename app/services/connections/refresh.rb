module Connections
  class Refresh
    attr_accessor :user, :gateway

    def initialize(user, gateway)
      self.user = user
      self.gateway = gateway
    end

    def call
      items = []

      begin
        items = gateway.connections(user.external_id)
      rescue StandardError => e
        Rails.logger.error e
      end

      items.each do |item|
        conn = Connection.where(external_id: item['id']).first
        conn ||= Connection.new(user: user, external_id: item['id'])
        conn.provider_code = item['provider_code']
        conn.provider_name = item['provider_name']
        conn.save!
      end
    end
  end
end
