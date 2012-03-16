class Membership < ActiveRecord::Base
  belongs_to :profile, :readonly => true
  belongs_to :club, :readonly => true

  attr_accessible :note
  attr_accessible :note, :state, :role, :as => :admin

  state_machine :state, :initial => :blocked do
    event :audit do
      transition [:blocked, :dismissed] => :audited
    end
    event :dismiss do
      transition :audited => :dismissed
    end
  end

  #state_machine :job, :initial => :recruit, :namespace => :job do
  #  event :be_staff  do
  #    transition [:recruit, :minister, :chairman] => :staff
  #  end
  #  event :be_chairman do
  #    transition [:recruit, :staff, :minister] => :chairman
  #  end
  #  event :be_minister do
  #    transition [:recruit, :staff, :chairman] => :minister
  #  end
  #end

  state_machine :role, :initial => :associator, :namespace => :role do
    event :be_admin do
      transition [:associator, :publisher, :authorizer] => :admin
    end
    event :be_publisher do
      transition [:associator, :authorizer, :admin] => :publisher
    end
    event :be_authorizer do
      transition [:associator, :publisher, :admin] => :authorizer
    end
    event :be_associator do
      transition [:publisher, :authorizer, :admin] => :associator
    end
  end

  scope :admin, with_role(:admin)
  scope :publisher, with_role(:publisher)
  scope :associator, with_role(:associator)

  #scope :recruit, with_job(:recruit)
  #scope :staff, with_job(:staff)
  #scope :minister, with_job(:minister)
  #scope :chairman, with_job(:chairman)

  scope :audited, with_state(:audited)
  scope :dismissed, with_state(:dismissed)
  scope :blocked, with_state(:blocked)
end
