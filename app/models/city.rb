class City < ActiveRecord::Base
  has_many :universities

  validates :name, :presence => true, :uniqueness => true
end
