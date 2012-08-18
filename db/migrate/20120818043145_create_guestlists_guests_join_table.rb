class CreateGuestlistsGuestsJoinTable < ActiveRecord::Migration
  def change
    create_table :guestlists_guests, id: false do |t|
      t.integer :guestlist_id
      t.integer :guest_id
    end
  end
end
