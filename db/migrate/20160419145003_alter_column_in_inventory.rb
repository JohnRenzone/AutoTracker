class AlterColumnInInventory < ActiveRecord::Migration
  def up
    change_column :inventories, :vin, :string
  end

  def down
    change_column :inventories, :vin, :integer
  end
end
