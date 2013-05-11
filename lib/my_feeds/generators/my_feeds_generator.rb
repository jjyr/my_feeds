require 'rails/generators'
require 'rails/generators/migration'

class MyFeedsGenerator < Rails::Generators::Base

  include Rails::Generators::Migration

  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  def create_migration_file
    migration_template 'migration.rb', 'db/migrate/my_feeds_migration.rb'
  end

  def create_model
    template "model.rb", File.join('app/models', "feed.rb")
  end
end
