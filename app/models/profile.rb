class Profile < ActiveRecord::Base
  belongs_to :user

  validates :email, :format => { :with => /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/i }
  validates :user_id, :presence => true, :uniqueness => true

  attr_accessible :name, :birth, :mobile, :email, :qq, :gender, :hometown, :bio, :user

  def sex
    self.gender == 1 ? 'male' : 'female'
  end
end
