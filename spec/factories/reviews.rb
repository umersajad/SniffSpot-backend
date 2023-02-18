# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    content { Faker::Lorem.paragraph }
    association :user, factory: :user
    association :spot, factory: :spot
  end
end
