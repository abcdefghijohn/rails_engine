FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
    created_at { "2020-12-14 17:42:10" }
    updated_at { "2020-12-14 17:42:10" }
  end
end
