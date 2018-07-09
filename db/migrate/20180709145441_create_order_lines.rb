class CreateOrderLines < ActiveRecord::Migration[5.2]
  def change
    create_table :order_lines do |t|
      t.integer :quantity
      t.references :order, foreign_key: true
      t.references :ticket, foreign_key: true

      t.timestamps
    end
  end
end
