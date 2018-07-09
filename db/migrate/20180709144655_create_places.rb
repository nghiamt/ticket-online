class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name
      t.string :description
      t.string :image_url1
      t.string :image_url2
      t.string :image_url3

      t.timestamps
    end
  end
end
