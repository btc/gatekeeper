class CreateCommitteesUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :committees_users, id: false do |t|
      t.integer :committee_id
      t.integer :user_id
    end
  end
end
