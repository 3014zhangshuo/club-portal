# -*- encoding : utf-8 -*-
### UTILITY METHODS ###

def create_visitor
  #@visitor ||= { :email => "example@example.com",
  #  :password => "please", :password_confirmation => "please" }
  @visitor ||= FactoryGirl.attributes_for(:a_user)
end

def find_user
  @user ||= User.first conditions: {:email => @visitor[:email]}
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
  visit '/user/sign_out'
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, email: @visitor[:email])
end

def delete_user
  @user ||= User.first conditions: {:email => @visitor[:email]}
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/user/sign_up'
  fill_in "邮箱", :with => @visitor[:email]
  fill_in "密码", :with => @visitor[:password]
  fill_in "确认密码", :with => @visitor[:password_confirmation]
  click_button "注册"
  find_user
end

def sign_in
  visit '/user/sign_in'
  fill_in "邮箱", :with => @visitor[:email]
  fill_in "密码", :with => @visitor[:password]
  click_button "登录"
end

### GIVEN ###
Given /^I am not logged in$/ do
  visit '/user/sign_out'
end

Given /^I am logged in$/ do
  create_user
  sign_in
end

Given /^I exist as a user$/ do
  create_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  visit '/user/sign_out'
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "please123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When /^I edit my account details$/ do
  click_link "账号资料设置"
  fill_in "新密码", :with => @visitor[:password]
  fill_in "确认新密码", :with => @visitor[:password_confirmation]
  fill_in "当前密码", :with => @visitor[:password]
  click_button "修改密码"
end

When /^I look at the list of users$/ do
  visit '/'
end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "登出"
  page.should_not have_content "注册"
  page.should_not have_content "登录"
end

Then /^I should be signed out$/ do
  page.should have_content "注册"
  page.should have_content "登录"
  page.should_not have_content "登出"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "在继续浏览之前请先激活您的帐号。"
end

Then /^I see a successful sign in message$/ do
  page.should have_content "登录成功。"
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "一封带有激活链接的邮件已被发送至您的邮箱，请访问邮件中的链接以便激活您的帐号。"
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email 是无效的"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password 不能为空字符"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  page.should have_content '登出成功。'
end

Then /^I see an invalid login message$/ do
  page.should have_content '无效的邮箱或者密码。'
end

Then /^I should see an account edited message$/ do
  page.should have_content '帐号资料更新成功。'
end

Then /^I should see my email$/ do
  create_user
  page.should have_content @user[:email]
end
