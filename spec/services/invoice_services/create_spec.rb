require 'rails_helper'

describe InvoiceServices::Create, type: :service do
  let(:user) { create(:user) }
  let(:invoice_line_item1) do
    {
      name: Faker::Lorem.sentence,
      quantity: 2,
      net_amount_cents: Money.new(20_000_000),
      gross_amount_cents: Money.new(20_000_000),
      price_net_cents: Money.new(20_000_000),
      vat: 23.0
    }
  end
  let(:invoice_line_item2) do
    {
      name: Faker::Lorem.sentence,
      quantity: 2,
      net_amount_cents: Money.new(20_000_000),
      gross_amount_cents: Money.new(20_000_000),
      price_net_cents: Money.new(20_000_000),
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
      total_net_amount: Money.new(60_000_00),
      total_gross_amount: Money.new(60_000_00),
      invoice_line_items: [invoice_line_item1, invoice_line_item2]
    }
  end

  subject { described_class.new(params, user) }  

  before { @result = subject.call }

  it 'creates invoice for the user' do
    expect(@result).to be_success
  end

  it 'creates invoice line items for the invoice' do
    invoice = Invoice.last
    expect(invoice.invoice_line_items.count).to eq(2)
  end

  it 'calls Invoices::GeneratePdfJob job to generate PDF' do
    ActiveJob::Base.queue_adapter = :test
    expect do
      Invoices::GeneratePdfJob.perform_later(@result.data)
    end.to enqueue_job(Invoices::GeneratePdfJob).with(@result.data)
  end
end
