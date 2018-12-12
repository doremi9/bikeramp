# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    sequence :email do |n|
      "#{n}-#{Faker::Internet.email}"
    end
    password "Password"
    password_confirmation "Password"
  end

  trait :with_avatar do
    avatar File.open('spec/fixtures/files/jpg.jpg')
  end

  trait :confirmed do
    confirmed_at Time.current
  end
end
