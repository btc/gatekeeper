class CreateGuestlists < ActiveRecord::Migration
  def change
    create_table :guestlists do |t|

      t.timestamps
    end
  end
end
