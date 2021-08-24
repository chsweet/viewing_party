FactoryBot.define do
  factory :attendee do
    association :party, factory: :party
    association :user, factory: :user
  end
end
