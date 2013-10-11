class EnrollSubject < ActiveRecord::Base
  belongs_to :enroll
  belongs_to :subject
end
