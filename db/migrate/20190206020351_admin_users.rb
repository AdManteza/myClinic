class AdminUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_users do |t|
      t.belongs_to :site
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :password_digest
      t.boolean :super, :default => false

      t.datetime :date

      t.timestamps
    end
  end
end
