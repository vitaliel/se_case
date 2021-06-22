class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :connection, foreign_key: true, null: false
      t.string :name, null: false
      t.string :nature, null: false
      t.float :balance, null: false
      t.string :currency_code, null: false
      t.string :external_id, null: false
      t.index :external_id

      t.timestamps
    end
  end
end
