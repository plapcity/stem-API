class CreateWomen < ActiveRecord::Migration[5.1]
  def change
    create_table :women do |t|
      t.string :name
      t.text :bio
      t.string :image_src

      t.timestamps
    end
  end
end
