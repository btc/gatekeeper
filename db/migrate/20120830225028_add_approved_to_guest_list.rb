class AddApprovedToGuestList < ActiveRecord::Migration
  def change
    add_column :guest_lists, :approved, :boolean, default: false
  end
end
