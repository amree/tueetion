class Enroll < ActiveRecord::Base
  belongs_to :student
  belongs_to :enrollable, polymorphic: true
  has_many :enroll_subjects
  has_many :subjects, through: :enroll_subjects

  accepts_nested_attributes_for :enroll_subjects
end
