class CreateCustomerJob < ApplicationJob
  queue_as :default

  def perform(user)
    return if user.external_id.present?

    data = Gateway.new.customer_register(user.email)
    user.external_id = data['id']
    user.save!
  end
end
