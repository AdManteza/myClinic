class AddSiteToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_reference :appointments, :site, foreign_key: true
  end
end
