require 'rails_helper'

describe InvoiceLineItem, type: :model do
  it { is_expected.to belong_to(:invoice) }
  it { is_expected.to monetize(:net_amount_cents) }
  it { is_expected.to monetize(:gross_amount_cents) }
end