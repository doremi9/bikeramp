class InvoiceLineItem < ApplicationRecord
  belongs_to :invoice

  monetize :net_amount_cents
  monetize :gross_amount_cents
  monetize :price_net_cents
end