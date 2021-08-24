FactoryBot.defince do
  factory :follow do
    association :user, factory: :user
  end
end
