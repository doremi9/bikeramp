require 'rails_helper'

describe Invoice, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:invoice_line_items) }
  it { is_expected.to monetize(:total_net_amount_cents) }
  it { is_expected.to monetize(:total_gross_amount_cents) }
end