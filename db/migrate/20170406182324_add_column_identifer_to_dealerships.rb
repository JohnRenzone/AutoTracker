class AddColumnIdentiferToDealerships < ActiveRecord::Migration
  def change
    add_column :dealerships, :identifier, :string
    Dealership.update_all "identifier = 'oakland'"
  end
end
