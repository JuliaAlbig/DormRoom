class AddImageFileToProducts < ActiveRecord::Migration
  def change
    add_column :products, :image_file, :string
  end
end
