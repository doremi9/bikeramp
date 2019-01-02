# frozen_string_literal: true

FactoryBot.define do
  factory :invoice_line_item do
    name Faker::Lorem.sentence
    quantity 2
    net_amount_cents Money.new(200000.00)
    gross_amount_cents Money.new(200000.00)
    price_net_cents Money.new(200000.00)
    vat 23.0
  end
end