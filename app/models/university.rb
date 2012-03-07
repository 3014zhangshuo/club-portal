class University < ActiveRecord::Base
  belongs_to :city

  validates :name, :presence => true, :uniqueness => true
  validates :city_id, :presence => true, :uniqueness => true
end
