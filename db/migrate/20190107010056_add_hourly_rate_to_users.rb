class AddHourlyRateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :hourly_rate, :string
  end
end
