class AddGenderToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :gender, :string
  end
end
