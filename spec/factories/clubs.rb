# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :club do
    factory :blocked_club do
      name "STAIT"
      permalink "stait"
      university
      club_type
      intro "MyText"
      state "blocked"
    end

    factory :audited_club do
      name "BUUXSH"
      permalink "buuxsh"
      university
      club_type
      intro "MyText"
      state "audited"
    end
  end
end
