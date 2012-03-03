class Profile < ActiveRecord::Base
  belongs_to :user

  def gender
    self.gender == 1 ? 'Male' : 'Female'
  end
end
