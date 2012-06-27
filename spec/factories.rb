FactoryGirl.define do

  sequence :email do |n|
    "person#{n.to_s + SecureRandom.hex}@example.com"
  end

  factory :user do
    email
    password SecureRandom.hex
    factory :admin do
      after(:create) { |user| user.admin = true }
    end
  end

  factory :role do
    name 'name'
    user
  end

end
