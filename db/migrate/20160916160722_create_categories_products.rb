class CreateCategoriesProducts < ActiveRecord::Migration
  def change
    create_table :categories_products, :id => false do |t|
      t.uuid :category_id
      t.uuid :product_id
    end

    add_index :categories_products, [:category_id, :product_id], :unique => true
  end
end
