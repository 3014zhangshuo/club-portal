class ClubType < ActiveRecord::Base

  has_many :clubs

  validates :name, :presence => true, :uniqueness => true

end
