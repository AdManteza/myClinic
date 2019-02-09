class AddHomepageToSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :homepage, :string, :default => 'homepage'
  end
end
