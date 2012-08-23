class RootController < ApplicationController
  layout 'resources'
  def index
    authorize! :go, :home
    @birthday_guests = Guest.find_ordered_birthdays_for_the_next_month
  end
end
