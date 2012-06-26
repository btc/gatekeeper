FactoryGirl.define do

  factory :user do
    salt = SecureRandom.hex
    email "user" + salt + "@example.com"
    password SecureRandom.hex
  end

  factory :role do
  end

end
