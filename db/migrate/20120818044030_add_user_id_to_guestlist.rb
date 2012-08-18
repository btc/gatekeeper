class AddUserIdToGuestlist < ActiveRecord::Migration
  def change
    add_column :guestlists, :user_id, :integer
  end
end
