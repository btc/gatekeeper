class AddRatingToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :rating, :integer
  end
end
