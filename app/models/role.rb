class Role < ActiveRecord::Base
  belongs_to :play

  # Although this is perfectly legal according to the spec
  # we usually don't do it because validations tend to 
  # change. If you put them on separate lines then it
  # makes diffs smaller and makes their intent more clear
  # because it shows the actual change in valdation
  # rather than line manipulation/overhead.
  validates_presence_of :name, :play
  validates_uniqueness_of :name, scope: :play_id
end
