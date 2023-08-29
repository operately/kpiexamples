FactoryBot.define do
  factory :notification do
    email { Faker::Internet.email }
    category { nil }
  end
end
