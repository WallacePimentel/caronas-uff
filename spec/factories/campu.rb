FactoryBot.define do
  factory :campu do
    fake_adress = Faker::Address.full_address.split(', ')
    name { Faker::University.name }
    city { fake_adress[0] }
    district { fake_adress[1] }
    deactivation_date { nil }
    status { :ativo }
  end
end

