class CreateRecharges < ActiveRecord::Migration[5.2]
  def change
    create_table :recharges do |t|
      t.references :user, foreign_key: true
      t.integer :amount, null: false
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
