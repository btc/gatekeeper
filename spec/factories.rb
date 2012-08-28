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
    name 'admin'
    user FactoryGirl.create(:user)
  end

  factory :guest do
    first_name 'brian'
    last_name 'lara'
    gender 'male'
  end
end
