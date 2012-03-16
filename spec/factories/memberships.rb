# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :membership do
    profile
    club
    note "MyString"
    role "admin"
    state "audited"
  end
end
