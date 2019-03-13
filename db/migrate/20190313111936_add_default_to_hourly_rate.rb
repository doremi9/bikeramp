class AddDefaultToHourlyRate < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :hourly_rate, :string, default: ''
  end

  def down
    change_column :users, :hourly_rate, :string, default: nil
  end
end
