module GuestListsHelper
  # returns a date object that represents the
  def this_friday
    day = Date.today
    until day.friday?
      day = day.next
    end
    day
  end

  def relative_date(date)
    n = (date - Date.today).to_int
    case
    when n == 0 then 'today'
    when n > 0 then "in #{n} days"
    when n == -1 then '1 day ago'
    else "#{-n} days ago"
    end
    # TODO FIXME handle case where it's like 3 am
  end
end
