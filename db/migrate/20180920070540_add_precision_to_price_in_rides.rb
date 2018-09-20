class AddPrecisionToPriceInRides < ActiveRecord::Migration[5.2]
  def change
    change_column :rides, :price, :decimal, precision: 10, scale: 2
  end
end
