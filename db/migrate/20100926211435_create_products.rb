class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :productId
      t.string :name
      t.string :sku
      t.string :imageURL
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
