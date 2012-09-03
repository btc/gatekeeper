class AddTableIdToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :table_id, :integer
  end
end
