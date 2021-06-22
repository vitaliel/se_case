class CreateConnections < ActiveRecord::Migration[6.1]
  def change
    create_table :connections do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.string :provider_code, null: false
      t.string :provider_name, null: false
      t.string :external_id, null: false
      t.index :external_id
      t.timestamps
    end
  end
end
