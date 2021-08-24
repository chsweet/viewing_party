FactoryBot.defince do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
