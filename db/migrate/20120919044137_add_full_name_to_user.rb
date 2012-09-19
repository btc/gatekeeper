class AddFullNameToUser < ActiveRecord::Migration
  def up
    unless column_exists? :users, :full_name
      add_column :users, :full_name, :string
    end

    if column_exists? :users, :last_name
      remove_column :users, :last_name
    end

    if column_exists? :users, :first_name
      remove_column :users, :first_name
    end
  end

  def down
    if column_exists? :users, :full_name
      remove_column :users, :full_name
    end

    unless column_exists? :users, :first_name
      add :users, :first_name
    end

    unless column_exists? :users, :last_name
      add :users, :last_name
    end
  end
end
