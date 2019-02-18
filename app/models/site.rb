class Site < ApplicationRecord
  has_many :users
  has_many :admin_users
  has_many :appointments
  has_many :patient_sessions

  validates_presence_of :name, :domain
end
