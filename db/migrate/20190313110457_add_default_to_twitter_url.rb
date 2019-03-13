class AddDefaultToTwitterUrl < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :twitter_url, :string, default: ''
  end

  def down
    change_column :users, :twitter_url, :string, default: nil
  end
end
