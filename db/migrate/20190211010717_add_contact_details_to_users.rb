class AddContactDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :contact_number, :string
    add_column :users, :email_address, :string
  end
end
