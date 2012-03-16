class Club < ActiveRecord::Base
  has_many :memberships
  has_many :profiles, :through => :memberships

  belongs_to :university, :readonly => true
  belongs_to :club_type, :readonly => true

  validates :name, :presence => true, :length => {:minimum => 3, :maximum => 10}
  validates :university_id, :presence => true
  validates :club_type_id, :presence => true

  validates :permalink, :presence => true,
                        :uniqueness => true,
                        :length => {:minimum => 5, :maximum => 12},
                        :format => {:with => /[a-z]{5,12}/i}

  attr_accessible :name, :permalink, :intro, :club_type_id
  attr_accessible :name, :permalink, :intro, :club_type_id, :university_id, :state, :as => :admin

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

end
