FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@example.com"}

  factory :user do
    email FactoryGirl.generate :email
    password SecureRandom.hex
  end

end
