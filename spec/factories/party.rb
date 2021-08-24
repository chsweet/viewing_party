FactoryBot.define do
  factory :party do
    movie { Faker::Internet.email }
    association :user, factory: :user
    duration { Faker::Number.between(from: 90, to: 200)}
    date { Faker::Date.forward(days:23) }
    # start_time { Faker::Time.}
  end
end
