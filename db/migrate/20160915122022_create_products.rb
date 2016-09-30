class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products, id: :uuid do |t|
      t.string :name
      t.text :description
      t.decimal :price, :precision => 8, :scale => 2
    end

    add_index :products, :name
    add_index :products, :price
    add_index :products, [ :name, :price]
  end
end
