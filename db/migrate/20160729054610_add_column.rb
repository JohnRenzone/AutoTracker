class AddColumn < ActiveRecord::Migration
  def change
    add_column :dealerships, :title, :string
    add_column :dealerships, :address, :text
  end
end
