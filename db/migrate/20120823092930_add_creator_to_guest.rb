class AddCreatorToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :creator_id, :integer
  end
end
