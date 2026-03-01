FactoryBot.define do
  factory :place do
    street { Faker::Address.street_name }
    number { Faker::Number.within(range:1..999) }
    district { Faker::Address.community }
    city { Faker::Address.city }
    CEP { Faker::Address.zip_code(state_abbreviation: '')}
    carpool { create(:carpool) }
  end
end
