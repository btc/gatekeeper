class CreateEventsGuestsJoinTable < ActiveRecord::Migration
  def change
    create_table :events_guests, id: false do |t|
      t.integer :event_id
      t.integer :guest_id
    end
  end
end
