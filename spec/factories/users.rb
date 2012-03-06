# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    password 'please'
    password_confirmation 'please'

    factory :a_user do
      email 'example@example.com'
    end
    factory :another_user do
      email 'jasl123@126.com'
    end
  end
end
