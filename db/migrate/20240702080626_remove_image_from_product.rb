class RemoveImageFromProduct < ActiveRecord::Migration[7.1]
  def up
    remove_column :products, :image
  end

  def down
    add_column :products, :image, :string
  end
end
