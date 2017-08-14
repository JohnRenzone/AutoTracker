class ChangeColumnInBatteries < ActiveRecord::Migration
  def up
    change_column :batteries, :factory_spec_amps, :integer
    change_column :batteries, :actual_amps, :integer
  end

  def down
    change_column :batteries, :factory_spec_amps, :decimal
    change_column :batteries, :actual_amps, :decimal
  end
end
