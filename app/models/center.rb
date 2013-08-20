class Center < ActiveRecord::Base
  validates :name, presence: true
end
