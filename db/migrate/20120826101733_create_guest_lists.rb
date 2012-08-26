class CreateGuestLists < ActiveRecord::Migration
  def change
    create_table :guest_lists do |t|
      t.integer :creator_id
      t.integer :owner_id
      t.integer :event_id
      t.date :date

      t.timestamps
    end
  end
end
