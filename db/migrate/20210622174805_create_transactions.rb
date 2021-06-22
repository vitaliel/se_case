class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :account, foreign_key: true, null: false
      t.string :status, null: false
      t.date :made_on, null: false
      t.float :amount, null: false
      t.string :currency_code, null: false
      t.string :external_id, null: false
      t.index :external_id

      t.string :category
      t.string :description

      t.timestamps
    end
  end
end
