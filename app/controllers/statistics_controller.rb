class StatisticsController < ApplicationController
  def index
    authorize! :read, :statistics
    @guest_lists = GuestList.tonight.approved

    @n_guests_on_lists_tonight = @guest_lists.inject(0) do |sum, list|
      sum + list.invitations.count
    end

    @n_check_ins_tonight = @guest_lists.inject(0) do |sum, list|
      sum + list.invitations.where('redeemed = ?', true).count
    end

    @pct_checked_in_tonight = (@n_check_ins_tonight.to_f / @n_guests_on_lists_tonight) * 100

  end
end
