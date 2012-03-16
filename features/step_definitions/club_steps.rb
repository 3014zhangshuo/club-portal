# -*- encoding : utf-8 -*-

Given /^I watch create new club page$/ do
  create_profile_attr
  @user.build_profile(@profile_attr).save
end
