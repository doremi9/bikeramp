class AddFileToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :file, :string
  end
end
