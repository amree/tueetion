class Option < ActiveRecord::Base
  belongs_to :center

  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone::MAPPING.collect { |v,k| v } }
end
