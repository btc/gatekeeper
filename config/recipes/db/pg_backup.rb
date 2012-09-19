namespace :db do
  require 'yaml'

  desc "Copy the remote production database to the local development database NOTE: postgreSQL specific"
  task :pg_backup, :roles => :db, :only => { :primary => true } do
    # First lets get the remote database config file so that we can read in the database settings
    tmp_db_yml = "tmp/database.yml"
    get("#{shared_path}/config/database.yml", tmp_db_yml)

    # load the production settings within the database file
    db = YAML::load_file("tmp/database.yml")["production"]
    run_locally("rm #{tmp_db_yml}")

    filename = "#{application}.dump.#{Time.now.to_i}.sql.bz2"
    file = "/tmp/#{filename}"
    on_rollback {
      run "rm #{file}"
      run_locally("rm #{tmp_db_yml}")
    }
    run "pg_dump --clean --no-owner --no-privileges -U #{db['username']} #{db['database']} | bzip2 > #{file}" do |ch, stream, out|
      ch.send_data "#{db['password']}\n" if out =~ /^Password:/
      puts out
    end
    run_locally "mkdir -p -v '#{File.dirname(__FILE__)}/../backups/'"
    get file, "backups/#{filename}"
    run "rm #{file}"
  end

  desc "Copy the latest backup to the local development database NOTE: postgreSQL specific"
  task :pg_import_backup do
    pg_drop_and_create_local_dbs

    filename = `ls -tr backups | tail -n 1`.chomp
    if filename.empty?
      logger.important "No backups found"
    else
      ddb = YAML::load_file("config/database.yml")["development"]
      logger.debug "Loading backups/#{filename} into local development database"
      ENV['PGPASSWORD'] = ddb['password']
      run_locally "bzip2 -cd backups/#{filename} | psql -U #{ddb['username']} -d #{ddb['database']}"
      logger.debug "command finished"
    end
  end

  desc "Backup the remote production database and import it to the local development database NOTE: postgreSQL specific"
  task :pg_backup_and_import do
    pg_backup
    pg_import_backup
  end

  desc "prepare local database for the incoming data"
  task :pg_drop_and_create_local_dbs do
    run_locally 'rake db:drop:all'
    run_locally 'rake db:create:all'
    run_locally 'rake db:migrate'
  end

end
