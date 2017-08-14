class AddDeletedAtToTables < ActiveRecord::Migration
  def change
    (ActiveRecord::Base.connection.tables - ["schema_migrations"]).each do |table|
      add_column table.to_sym, :deleted_at, :datetime
      add_index table.to_sym, :deleted_at
    end
  end
end
