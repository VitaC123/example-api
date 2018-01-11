require 'sequel'
require 'json'
require_relative 'example_api'

DB = Sequel.connect(ENV['DATABASE_URL'] || JSON.parse(File.read('./git_ignore/dev_config_vars.json'))['DATABASE_URL'])

run ExampleApi

# Start app with `rackup config.ru`
