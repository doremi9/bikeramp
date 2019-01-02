require 'rails_helper'

describe InvoiceServices::Create, type: :service do
  let(:user) { create(:user) }
  let(:invoice_line_item1) do
    {
      name: Faker::Lorem.sentence,
      quantity: 2,
      net_amount_cents: Money.new(20_0000_00),
      gross_amount_cents: Money.new(20_0000_00),
      price_net_cents: Money.new(20_0000_00),
      vat: 23.0
    }
  end
  let(:invoice_line_item2) do
    {
      name: Faker::Lorem.sentence,
      quantity: 1,
      net_amount_cents: Money.new(30_0000_00),
      gross_amount_cents: Money.new(30_0000_00),
      price_net_cents: Money.new(40_0000_00),
      vat: 23.0
    }
  end
  let(:params) do
    {
      number: Faker::Lorem.characters(6),
      creation_date: Date.current,
      sale_date: Date.current,
      due_date: Date.current + 14.days,
      currency: Faker::Currency.code,
      payment_method: 'transfer',
      total_net_amount_cents: Money.new(60_000_00),
      total_gross_amount_cents: Money.new(60_0000_00),
      payment_status: 'pending',
      invoice_line_items: [invoice_line_item1, invoice_line_item2]
    }
  end

  subject { described_class.new(params, user) }

  context 'when user passes valid params' do
    before { @result = subject.call }

    it 'creates invoice for the user' do
      expect(@result).to be_success
    end

    it 'creates invoice line items for the invoice' do
      expect(@result.data.invoice_line_items.count).to eq(2)
    end

    it 'calls Invoices::GeneratePdfJob job t ogenerate PDF' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        Invoices::GeneratePdfJob.perform_later(@result.data)
      }.to enqueue_job(Invoices::GeneratePdfJob).with(@result.data)
    end
  end

  xcontext 'when I pass invalid params' do
    it 'does not create invoice' do

    end
  end
end