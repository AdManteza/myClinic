class RemoveDateFromSites < ActiveRecord::Migration[5.2]
  def change
    remove_column :sites, :date
  end
end
