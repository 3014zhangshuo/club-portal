require 'spec_helper'

describe Club do

  it "should create a new instance given a valid attribute" do
    @type = FactoryGirl.create(:club_type)
    @university = FactoryGirl.create(:university)
    @club_attr = FactoryGirl.attributes_for(:blocked_club)
    @club_attr[:club_type_id] = @type.id
    @club_attr[:university_id] = @university.id
    @club = Club.create @club_attr
    @club.should be_valid
  end

  it "should transfer state from blocked to audited" do
    @club = FactoryGirl.create(:blocked_club)
    @club.audit!
    @club.state.should == "audited"
  end

  it "should transfer state from audited to blocked" do
    @club = FactoryGirl.create(:audited_club)
    @club.block!
    @club.state.should == "blocked"
  end

  it "should be viewed by permalink" do
    FactoryGirl.create(:audited_club)
    FactoryGirl.create(:blocked_club, :club_type_id => 1, :university_id => 1)
    Club.fetch("buuxsh").should be_valid
    Club.fetch("stait").should nil
  end

  it "should be listed after audit" do
    FactoryGirl.create(:audited_club)
    FactoryGirl.create(:blocked_club, :club_type_id => 1, :university_id => 1)
    Club.all.count.should == 1
  end
end
