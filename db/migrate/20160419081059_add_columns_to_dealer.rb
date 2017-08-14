class AddColumnsToDealer < ActiveRecord::Migration
  def change
    add_column :dealers, :dealer_id, :integer, references: :users, index: true
    add_column :dealers, :technician_id, :integer, references: :users, index: true
  end
end