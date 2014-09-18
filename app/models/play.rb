class Play < ActiveRecord::Base
  has_many :roles

  validates_presence_of :title, :total_scenes
  validates_uniqueness_of :title
end
