class RenamePriceToPriceCentsInRides < ActiveRecord::Migration[5.2]
  def self.up
    rename_column :rides, :price, :price_cents
  end

  def self.down
    rename_column :rides, :price_cents, :price
  end
end
