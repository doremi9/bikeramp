class CreateInvoiceLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_line_items do |t|
      t.string :name
      t.integer :quantity
      t.bigint :net_amount_cents, default: 0
      t.bigint :gross_amount_cents, default: 0
      t.float :vat, default: 0.0
      t.bigint :price_net_cents, default: 0
      t.belongs_to :invoice, foreign_key: true
      t.timestamps
    end
  end
end
