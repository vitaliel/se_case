FactoryBot.define do
  factory :transaction do
    account
    status { 'posted' }
    made_on { Date.today }
    amount { 10 }
    currency_code { 'EUR' }
    sequence(:external_id) { |n| "44444#{n}" }
  end
end
