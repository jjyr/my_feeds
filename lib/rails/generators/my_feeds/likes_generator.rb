module MyFeeds
  module Generators
    class LikesGenerator < Rails::Generators::Base

      include Rails::Generators::Migration

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), '../templates')
      end

      def create_migration_file
        migration_template 'likes_migration.rb', 'db/migrate/likes_migration.rb'
      end

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

      def create_model
        template "like_model.rb", File.join('app/models', "like.rb")
      end
    end
  end
end

