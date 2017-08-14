class CreateTableDealerships < ActiveRecord::Migration
  def up
    create_table :dealerships do |t|
      t.timestamps null: false
      t.timestamp :deleted_at
    end

    drop_table :dealers

    remove_column :users, :parent_id

    add_column :users, :dealership_id, :integer
  end

  def down
    create_table :dealers do |t|
      t.integer :user_id, :dealer_id, :techincian_id
      t.timestamps null: false
    end

    remove_table :dealerships

    add_column :users, :parent_id, :integer

    remove_column :users, :dealership_id
  end
end
