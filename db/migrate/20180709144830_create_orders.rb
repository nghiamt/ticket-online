class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :receiver_name
      t.string :receiver_address
      t.integer :total_amount
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
