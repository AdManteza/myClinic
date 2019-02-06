class Site < ApplicationRecord
  has_many :users
  has_many :admin_users

  validates_presence_of :name, :domain
end
