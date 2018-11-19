class ChangePriceToBeFloatInRides < ActiveRecord::Migration[5.2]
  def up
    change_column :rides, :price, :float, precision: 10, scale: 2
  end

  def down
    change_column :rides, :price, :decimal, precision: 10, scale: 2
  end
end
