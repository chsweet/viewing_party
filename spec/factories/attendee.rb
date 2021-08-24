FactoryBot.defince do
  factory :party do
    association :party, factory: :party
    association :user, factory: :user
  end
end
