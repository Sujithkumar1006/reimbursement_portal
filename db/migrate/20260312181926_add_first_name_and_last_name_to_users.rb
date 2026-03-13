class AddFirstNameAndLastNameToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :first_name, :string
    rename_column :users, :name, :last_name
  end
end
