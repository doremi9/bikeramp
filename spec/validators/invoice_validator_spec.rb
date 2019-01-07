# frozen_string_literal: true

require 'rails_helper'

describe InvoiceValidator, type: :validator do
  let(:user) { create(:user) }
  let(:invoice_line_item1) do
    {
      name: name,
      quantity: quantity,
      net_amount_cents: net_amount_cents,
      gross_amount_cents: gross_amount_cents,
      price_net_cents: price_net_cents,
      vat: vat
    }
  end
  let(:invoice_line_item2) do
    {
      name: name,
      quantity: quantity,
      net_amount_cents: net_amount_cents,
      gross_amount_cents: gross_amount_cents,
      price_net_cents: price_net_cents,
      vat: vat
    }
  end
  let(:params) do
    {
      number: number,
      creation_date: creation_date,
      sale_date: sale_date,
      due_date: due_date,
      currency: currency,
      payment_method: payment_method,
      total_net_amount: total_net_amount,
      total_gross_amount: total_gross_amount,
      invoice_line_items: [invoice_line_item1, invoice_line_item2]
    }
  end

  subject { described_class.new(params) }

  context 'when I pass valid params' do
    let(:name) { Faker::Lorem.sentence }
    let(:quantity) { 2 }
    let(:net_amount_cents) { Money.new(20_000_000) }
    let(:gross_amount_cents) { Money.new(20_000_000) }
    let(:price_net_cents) { Money.new(20_000_000) }
    let(:vat) { 23.0 }
    let(:number) { Faker::Lorem.characters(6) }
    let(:creation_date) { Date.current }
    let(:sale_date) { Date.current }
    let(:due_date) { Date.current + 14.days }
    let(:currency) { Faker::Currency.code }
    let(:payment_method) { 'transfer' }
    let(:total_net_amount) { Money.new(60_000_00) }
    let(:total_gross_amount) { Money.new(60_000_000) }

    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  context 'when I pass invalid params' do
    let(:name) { '' }
    let(:quantity) { '' }
    let(:net_amount_cents) { '' }
    let(:gross_amount_cents) { '' }
    let(:price_net_cents) { '' }
    let(:vat) { '' }
    let(:number) { '' }
    let(:creation_date) { '' }
    let(:sale_date) { '' }
    let(:due_date) { '' }
    let(:currency) { '' }
    let(:payment_method) { '' }
    let(:total_net_amount) { '' }
    let(:total_gross_amount) { '' }

    it 'is invalid' do
      expect(subject).to be_invalid
    end
  end
end
