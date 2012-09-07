class AddTitleToCommittee < ActiveRecord::Migration
  def change
    add_column :committees, :title, :string
  end
end
