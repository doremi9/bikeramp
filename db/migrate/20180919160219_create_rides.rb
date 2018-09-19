class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.string :start_address
      t.string :destination_address
      t.integer :distance
      t.float :price
      t.date :date
    end
  end
end
