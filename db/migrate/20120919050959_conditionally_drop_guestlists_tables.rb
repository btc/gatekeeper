class ConditionallyDropGuestlistsTables < ActiveRecord::Migration
  def up
    if table_exists? :guestlists
      drop_table :guestlists
    end

    if table_exists? :guestlists_guests
      drop_table :guestlists_guests
    end
  end
end
