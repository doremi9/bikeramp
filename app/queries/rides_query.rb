class RidesQuery
  def rides_weekly
    Ride.where(date: Date.current.beginning_of_week..Date.current.end_of_week)
  end

  def rides_monthly
    Ride.where(
      date: Date.current.beginning_of_month..Date.current.end_of_month
    ).order('date ASC').group_by(&:date)
  end
end
