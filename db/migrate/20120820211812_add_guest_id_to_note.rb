class AddGuestIdToNote < ActiveRecord::Migration
  def change
    add_column :notes, :guest_id, :integer
  end
end
