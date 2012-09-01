class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :guest_id
      t.integer :guest_list_id
      t.integer :event_id
      t.integer :plus, default: 0
      t.boolean :redeemed, default: false

      t.timestamps
    end
  end
end
