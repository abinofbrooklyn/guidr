class DateRange < ActiveRecord::Base
  def days_in_range
    (start_date...end_date).count
  end
end
