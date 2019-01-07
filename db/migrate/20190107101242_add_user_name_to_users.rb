class AddUserNameToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :username, :string
    User.find_each do |user|
      username = [user.first_name, rand(1..100)].join.downcase
      user.username = username
      user.save
    end
  end

  def down
    remove_column :users, :username
  end
end
