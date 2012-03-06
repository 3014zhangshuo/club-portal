# -*- encoding : utf-8 -*-

def delete_profile
  @user = User.first conditions: {:email => @visitor[:email]}
  @user.profile.destroy unless @user.profile.nil?
end

def create_profile_attr
  @profile_attr = FactoryGirl.attributes_for(:profile)
end

Given /^I do not fulfill my profile$/ do
  delete_profile
  create_profile_attr
end

Given /^I have fulfilled my profile$/ do
  create_profile_attr
  @user.build_profile(@profile_attr).save
end

Given /^I fulfill my profile$/ do
  click_link "账号资料设置"
  fill_in "姓名", :with => @profile_attr[:name]
  select "年", :with => Time.now.year - 10
  select "月", :with => Time.now.month
  select "日", :with => Time.now.day
  fill_in "手机", :with => @profile_attr[:mobile]
  fill_in "邮箱", :with => @profile_attr[:email]
  fill_in "QQ", :with => @profile_attr[:qq]
  choose '男'
  fill_in "家乡", :with => @profile_attr[:hometown]
  fill_in "个人简介", :with => @profile_attr[:bio]
  click_button "更新我的资料"
end

Given /^I modify my profile$/ do
  click_link "账号资料设置"
  fill_in "姓名", :with => @profile_attr[:name]
  select "年", :with => Time.now.year - 11
  select "月", :with => Time.now.month
  select "日", :with => Time.now.day
  fill_in "手机", :with => @profile_attr[:mobile]
  fill_in "邮箱", :with => @profile_attr[:email]
  fill_in "QQ", :with => @profile_attr[:qq]
  choose '男'
  fill_in "家乡", :with => @profile_attr[:hometown]
  fill_in "个人简介", :with => @profile_attr[:bio]
  click_button "更新我的资料"
end

Then /^I see an success created message$/ do
  page.should have_content '个人资料保存成功，现在你可以使用全部功能了。'
end

Then /^I see an success updated message$/ do
  page.should have_content '个人资料修改成功。'
end