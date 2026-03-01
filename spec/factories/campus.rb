FactoryBot.define do
  factory :campu do
    description { Faker::University.name }
    street_adress { Faker::Address.street_name }
    number { Faker::Number.within(range:1..999) }
    district { Faker::Address.community }
    city { Faker::Address.city }
    CEP { Faker::Address.zip_code(state_abbreviation: '')}
    deactivation_date { nil }
    status { 0 }
  end
end
