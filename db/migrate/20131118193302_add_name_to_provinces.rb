class AddNameToProvinces < ActiveRecord::Migration
  def change
    add_column :provinces, :name, :string
  end
end
