# frozen_string_literal: true

FactoryBot.define do
  factory :spot do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.between(from: 10, to: 1000) }
    association :user, factory: :user
  end
end
