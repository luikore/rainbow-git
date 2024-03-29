def connect
  require "sequel"
  Sequel.extension :migration
  ENV["RACK_ENV"] ||= "development"
  require_relative "../../config/database"
end

namespace :db do
  desc "Perform migration reset (full erase and migration up)"
  task :setup do
    connect
    Sequel::Migrator.run(DB, "db/migrations", :target => 0)
    Sequel::Migrator.run(DB, "db/migrations")
    puts "<= sq:migrate:reset executed"
  end

  desc "Perform migration up/down to VERSION"
  task :version do
    connect
    version = ENV['VERSION'].to_i
    raise "No VERSION was provided" if version.nil?
    Sequel::Migrator.run(DB, "db/migrations", :target => version)
    puts "<= sq:migrate:to version=[#{version}] executed"
  end

  desc "Perform migration up to latest migration available"
  task :migrate do
    connect
    Sequel::Migrator.run(DB, "db/migrations")
    puts "<= sq:migrate:up executed"
  end

  desc "Perform migration down (erase all data)"
  task :rollback do
    connect
    Sequel::Migrator.run(DB, "db/migrations", :target => 0)
    puts "<= sq:migrate:down executed"
  end

  desc "Create new migration"
  task :'migration:new' do
    file = "db/migrations/#{Time.now.to_i}_.rb"
    FileUtils.touch file
    puts "created : #{file}"
  end
end
