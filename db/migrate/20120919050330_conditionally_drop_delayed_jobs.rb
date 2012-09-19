class ConditionallyDropDelayedJobs < ActiveRecord::Migration
  def up
    if table_exists? :delayed_jobs
      drop_table :delayed_jobs
    end
  end
end
