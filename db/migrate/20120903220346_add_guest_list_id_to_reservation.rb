class AddGuestListIdToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :guest_list_id, :integer
  end
end
