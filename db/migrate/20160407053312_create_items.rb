class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :vehicle, index: true, foreign_key: true
      t.string :key
      t.text :value
      t.string :unit

      t.timestamps null: false
    end



    add_column :items, :deleted_at, :datetime
    add_index :items, :deleted_at
  end
end
