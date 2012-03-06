# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Profile do
  before(:each) do
    @user = FactoryGirl.create(:a_user)
    @attr = FactoryGirl.attributes_for(:profile)
  end

  it "should create a new instance given a valid attribute and a user" do
    @profile = @user.build_profile @attr
    @profile.save
  end

  it "should not create a new instance without a user given a valid attribute" do
    @profile = Profile.new @attr
    @profile.should_not be_valid
  end

end
