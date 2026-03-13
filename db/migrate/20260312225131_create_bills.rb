class CreateBills < ActiveRecord::Migration[8.1]
  def change
    create_table :bills do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2
      t.integer :bill_type
      t.integer :status

      t.timestamps
    end
  end
end
