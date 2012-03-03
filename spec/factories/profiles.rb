# -*- encoding : utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    user nil
    name "姜军"
    birth "1991-08-07"
    mobile "13621000000"
    email "jasl@126.com"
    qq "195454000"
    gender 1
    hometown "北京"
    bio "我最厉害！"
  end
end
