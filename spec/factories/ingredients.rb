FactoryBot.define do
  factory :ingredient do
    name_qty do
      "#{Faker::Food.measurement} of #{Faker::Food.ingredient}"
    end
    recipe
  end
end
