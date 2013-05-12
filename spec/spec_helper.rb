$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'active_record'
require 'my_feeds'

require 'models/feed'
require 'models/like'
require 'models/post'
require 'models/user'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
ActiveRecord::Migration.verbose = false
load(File.dirname(__FILE__) + '/schema.rb')
