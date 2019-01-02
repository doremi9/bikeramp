# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    number Faker::Lorem.characters(6)
    creation_date Date.current
    sale_date Date.current
    due_date Date.current + 14.days
    currency Faker::Currency.code
    payment_method 'transfer'
    total_net_amount_cents Money.new(60_000_00)
    total_gross_amount_cents Money.new(60_0000_00)
    payment_status 'pending'
  end
end