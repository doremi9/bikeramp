class AddRidesCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :rides_count, :integer, default: 0, null: false
    User.find_each { |u| User.reset_counters(u.id, :rides) }
  end
end
