FactoryBot.define do
  factory :connection do
    user
    provider_name { 'Test Bank' }
    provider_code { 'test_bank' }
    sequence(:external_id) { |n| "22222#{n}" }
  end
end
