class AddRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :integer, default: 1

    # Update Admin role from already existing column for admin
    User.all.each { |user| user.update_attribute(:role,0) if user.is_admin? }
  end
end
