class AddDefaultPaymentStatusToInvoices < ActiveRecord::Migration[5.2]
  def self.up
    change_column_default :invoices, :payment_status, from: nil, to: 'pending'
  end

  def self.down
    change_column_default :invoices, :payment_status, from: 'pending', to: nil
  end
end
