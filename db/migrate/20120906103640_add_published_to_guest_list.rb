class AddPublishedToGuestList < ActiveRecord::Migration
  def change
    add_column :guest_lists, :published, :boolean, default: false
  end
end
