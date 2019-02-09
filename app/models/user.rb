class User < ApplicationRecord
  has_secure_password

  belongs_to :site
  has_many :appointments

  default_scope { order(created_at: :desc) }

  validates_presence_of :username, :firstname, :lastname

  def full_name
    "#{firstname} #{lastname}"
  end
end
