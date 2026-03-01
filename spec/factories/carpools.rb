FactoryBot.define do
  factory :carpool do
    beginning_campus { create(:campu) }
    ending_campus { create(:campu) }
    departure_time { Time.now }
    passengers { Faker::Number.within(range:1..4) }
    driver { Faker::Name.name }
    observation { Faker::Lorem.sentence }
    price_per_person { Faker::Number.within(range: 0.0..15.0)}
  end
end
