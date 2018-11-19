class AddDefaultValueToPriceCentsInRide < ActiveRecord::Migration[5.2]
  def change
    change_column :rides, :price_cents, :float, default: 0
  end
end
