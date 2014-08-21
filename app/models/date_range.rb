class DateRange < ActiveRecord::Base
  def days_in_range
    end_date - start_date
  end
end
