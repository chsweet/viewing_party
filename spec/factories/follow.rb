FactoryBot.define do
  factory :follow do
    association :user, factory: :user
  end
end
