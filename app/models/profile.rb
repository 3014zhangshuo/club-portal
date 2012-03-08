class Profile < ActiveRecord::Base
  belongs_to :user

  validates :email, :format => {:with => /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/i}
  validates :user_id, :presence => true, :uniqueness => true
  validates :gender, :inclusion => %w(male female)
  validates :qq, :format => {:with => /[0-9]{5,15}/i}

  attr_accessible :name, :birth, :mobile, :email, :qq, :gender, :hometown, :bio, :user
end
