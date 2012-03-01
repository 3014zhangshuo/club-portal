FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'
    confirmed_at Time.now unless Devise::Models::Confirmable.nil?
  end
end