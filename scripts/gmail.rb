require 'rubygems'
require 'gmail'
require 'yaml'
secrets = YAML.load_file(ENV['HOME']+'/.conky/secrets.yml')
gmail = Gmail.new(secrets['gmail']['login'], secrets['gmail']['password'])
puts gmail.inbox.count(:unread)
gmail.logout
