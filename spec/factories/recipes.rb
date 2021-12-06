FactoryBot.define do
  factory :recipe do
    name do
      Faker::Food.dish
    end
  end
end
