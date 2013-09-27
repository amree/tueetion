class Enroll < ActiveRecord::Base
  belongs_to :student
  belongs_to :enrollable, polymorphic: true
end
