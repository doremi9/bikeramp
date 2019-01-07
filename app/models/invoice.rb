class Invoice < ApplicationRecord
  belongs_to :user
  has_many :invoice_line_items
  has_one :invoice_file

  mount_uploader :file, InvoiceFileUploader
  monetize :total_net_amount_cents
  monetize :total_gross_amount_cents
end