class AddEmailfromToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :emailfrom, :string
  end

  def self.down
    remove_column :products, :emailfrom
  end
end
