class University < ActiveRecord::Base

  belongs_to :city

  has_many :clubs

  validates :name, :presence => true, :uniqueness => true
end
