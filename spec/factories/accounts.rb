FactoryBot.define do
  factory :account do
    user
    connection
    name { 'Test account' }
    nature { 'Card' }
    balance { 100 }
    currency_code { 'EUR' }
    sequence(:external_id) { |n| "33333#{n}" }
  end
end
