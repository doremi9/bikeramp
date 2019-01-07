# frozen_string_literal: true

FactoryBot.define do
  factory :ride do
    start_address { 'Plac Europejski 2, Warszawa' }
    destination_address { 'Aleje Jerozolimskie 10, Warszawa' }
    price_cents { Money.new(60_000) }
    date { Date.current }
  end
end