class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.string :number
      t.date :creation_date
      t.date :sale_date
      t.date :due_date
      t.string :currency
      t.string :payment_method
      t.bigint :total_net_amount_cents, default: 0
      t.bigint :total_gross_amount_cents, default: 0
      t.string :payment_status
      t.boolean :paid, default: false
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
