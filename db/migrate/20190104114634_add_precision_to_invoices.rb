class AddPrecisionToInvoices < ActiveRecord::Migration[5.2]
  def self.up
    change_column :invoices, :total_net_amount_cents, :decimal, precision: 10, scale: 2, default: 0.00
    change_column :invoices, :total_gross_amount_cents, :decimal, precision: 10, scale: 2, default: 0.00
  end

  def self.down
    change_column :invoices, :total_net_amount_cents, :bigint
    change_column :invoices, :total_gross_amount_cents, :bigint
  end
end
