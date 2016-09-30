class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name
      t.uuid :parent_id
    end

    add_index :categories, :name
    add_index :categories, :parent_id
  end
end
