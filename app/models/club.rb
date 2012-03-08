class Club < ActiveRecord::Base

  belongs_to :university
  belongs_to :club_type

  validates :name, :presence => true, :uniqueness => true
  validates :university_id, :presence => true
  validates :club_type_id, :presence => true

  validates :permalink, :presence => true, :uniqueness => true, :format => {:with => /[a-z]{5,12}/i}

  def Club.fetch key
    begin
      if key.to_i == 0
        self.find_by_permalink key
      else
        self.find key
      end
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

  state_machine :initial => :blocked do
    state :audited

    event :audit do
      transition :blocked => :audited
    end

    event :block do
      transition :audited => :blocked
    end
  end

  scope :audited, with_state(:audited)
  scope :blocked, with_state(:blocked)

  default_scope audited

end
