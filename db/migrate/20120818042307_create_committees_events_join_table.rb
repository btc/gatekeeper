class CreateCommitteesEventsJoinTable < ActiveRecord::Migration
  def change
    create_table :committees_events, id: false do |t|
      t.integer :committee_id
      t.integer :event_id
    end
  end
end
