class CreateCategoryShips < ActiveRecord::Migration
  def change
    create_table :category_ships do |t|

      t.integer :post_id
      t.integer :category_id

      t.timestamps null: false
    end

    add_index :category_ships, :post_id
    add_index :category_ships, :category_id

  end
end
