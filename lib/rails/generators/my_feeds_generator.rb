require 'rails/generators/active_record'

module MyFeeds
  module Generators
    class MyFeedsGenerator < ActiveRecord::Generators::Base

      argument :name, :type => :string, :default => 'my_feeds'

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def create_migration
        migration_template 'feeds_migration.rb', 'db/migrate/my_feeds_migration.rb'
      end

      def create_model
        template "feed.rb", File.join('app/models', "feed.rb")
      end
    end
  end
end
