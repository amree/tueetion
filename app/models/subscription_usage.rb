class SubscriptionUsage
  def initialize(center)
    @center = center
  end

  def max
    Subscription.where(center: @center)
                .where("? >= start_at and ? <= end_at", Time.now, Time.now)
                .sum(:quantity)
  end

  def current
    Student.where(center: @center).active.count
  end

  def balance
    max - current
  end
end
