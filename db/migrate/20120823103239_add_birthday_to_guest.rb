class AddBirthdayToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :birthday, :date
  end
end
