require 'rails_helper'

describe InvoiceServices::LineItemsCalculator, type: :service do
  let(:user) { create(:user) }
  let!(:invoice) { create(:invoice, user: user) }
  let!(:line_item1) do
    create(:invoice_line_item, gross_amount_cents: Money.new(20_000_00), invoice: invoice)
  end
  let!(:line_item2) do
    create(:invoice_line_item, gross_amount_cents: Money.new(20_000_00), invoice: invoice)
  end
  let!(:line_item3) do
    create(:invoice_line_item, gross_amount_cents: Money.new(20_000_00), invoice: invoice)
  end
  let(:total) { 60000.00 }

  specify 'calculates total gross amount of all invoice line items' do
    expect(described_class.calculate_total_amount(invoice)).to eq(total)
  end
end