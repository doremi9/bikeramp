class AddPrecisionToInvoiceLineItems < ActiveRecord::Migration[5.2]
  def self.up
    change_column :invoice_line_items, :price_net_cents, :decimal, precision: 10, scale: 2, default: 0.00
    change_column :invoice_line_items, :net_amount_cents, :decimal, precision: 10, scale: 2, default: 0.00
    change_column :invoice_line_items, :gross_amount_cents, :decimal, precision: 10, scale: 2, default: 0.00
  end

  def self.down
    change_column :invoice_line_items, :price_net_cents, :bigint
    change_column :invoice_line_items, :net_amount_cents, :bigint
    change_column :invoice_line_items, :gross_amount_cents, :bigint
  end
end
