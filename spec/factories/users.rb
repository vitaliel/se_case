FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "login-#{n}@dev.dev" }
    sequence(:external_id) { |n| "11111#{n}" }
    password { '123-)12s' }
  end
end
