class User < ApplicationRecord
  has_secure_password

  has_many :appointments

  default_scope { order(created_at: :desc) }

  validates_presence_of :username, :firstname, :lastname
end
