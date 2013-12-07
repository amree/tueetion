class Message < ActiveRecord::Base
  belongs_to :center
  belongs_to :student
end
