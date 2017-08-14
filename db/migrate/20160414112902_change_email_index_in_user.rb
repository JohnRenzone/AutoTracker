class ChangeEmailIndexInUser < ActiveRecord::Migration
  def up
    execute 'drop INDEX index_users_on_lower_email_index'
  end

  def down
    execute 'CREATE UNIQUE INDEX index_users_on_lower_email_index ON users (lower(email))'
  end
end