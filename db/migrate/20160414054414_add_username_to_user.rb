class AddUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, default: ''
    change_column :users, :email, :string, :null => false
  end
end