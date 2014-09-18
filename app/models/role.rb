class Role < ActiveRecord::Base
  belongs_to :play

  validates_presence_of :name, :play
  validates_uniqueness_of :name, scope: :play_id
end
