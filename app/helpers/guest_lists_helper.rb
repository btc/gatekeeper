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

  def status_badge(guest_list)
    if guest_list.pending?
      "<span class='label label-warning'>pending</span>".html_safe
    elsif guest_list.approved?
      "<span class='label label-success'>approved</span>".html_safe
    elsif guest_list.draft?
      "<span class='label'>draft</span>".html_safe
    elsif guest_list.invalid?
      "<span class='label label-important'>invalid state</span>".html_safe
    else
      ''
    end
  end
end
