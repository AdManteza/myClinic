class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :firstname, :lastname, :contact_number, :email_address, :full_name
end
