class ChangeColumnToLocation < ActiveRecord::Migration
  def change
    remove_column :locations, :name
    add_column :locations, :longitude, :float
    add_column :locations, :latitude, :float
  end
end
