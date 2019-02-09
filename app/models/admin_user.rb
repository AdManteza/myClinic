class AdminUser < ApplicationRecord
  has_secure_password

  belongs_to :site

  validates_presence_of :username, :firstname, :lastname
end
