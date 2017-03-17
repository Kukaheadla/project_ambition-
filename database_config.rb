require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'project_ambition'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
