FactoryBot.define do
  factory :site do
    name 'Test Site'
    domain 'test_site.com'
    homepage 'test_site'
    time_zone 'UTC'
  end

  factory :user do
    site
    username 'UserName'
    firstname 'First Name'
    lastname 'Last Name'
    password 'password'
    contact_number '123-4567'
    email_address 'user_email@email.com'
  end
end
