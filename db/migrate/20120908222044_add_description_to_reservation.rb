class AddDescriptionToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :description, :text
  end
end
