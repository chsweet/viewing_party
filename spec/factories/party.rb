FactoryBot.define do
  factory :party do
    movie { Faker::Movie }
    association :user, factory: :user
    duration { Faker::Number.between(from: 90, to: 200)}
    date_time { Faker::Time.forward(days: 23, period: :afternoon) }
  end
end
