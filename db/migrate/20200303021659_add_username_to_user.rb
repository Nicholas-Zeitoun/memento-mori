class AddUsernameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :location, :string
    add_column :users, :avatar_url, :string
  end
end
