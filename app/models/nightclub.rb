class Nightclub
  def self.today
    # if it is before 8 am show previous day
    def self.after_hours?
      true if Time.now.hour < 8
    end

    # else today
    day = Date.today
    if self.after_hours?
      day.prev_day
    else
      day
    end
  end
end
