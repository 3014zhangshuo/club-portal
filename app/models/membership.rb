class Membership < ActiveRecord::Base
  belongs_to :profile, :readonly => true
  belongs_to :club, :readonly => true

  attr_accessible :note
  attr_accessible :note, :state, :role_level, :as => :admin

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

  def owner?
    self.role_level == 0 ? true : false
  end

  def admin?
    self.role_level <= 1 ? true : false
  end

  def publisher?
    self.role_level <= 9 ? true : false
  end

  def transfer_owner member_id
    unless self.class.exists? member_id
      self.transaction do
        @new_owner = self.class.find member_id
        begin
          if (self.update_attribute :role_level, 1) and (@new_owner.update_attribute :role_level, 0)
            return true
          end
        rescue Exception
          return false
        end
      end
    end
    false
  end

  #scope :recruit, with_job(:recruit)
  #scope :staff, with_job(:staff)
  #scope :minister, with_job(:minister)
  #scope :chairman, with_job(:chairman)

  scope :audited, with_state(:audited)
  scope :dismissed, with_state(:dismissed)
  scope :blocked, with_state(:blocked)
end
