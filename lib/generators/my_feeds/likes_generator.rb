require 'rails/generators/active_record'

module MyFeeds
  module Generators
    class LikesGenerator < ActiveRecord::Generators::Base

      argument :name, :type => :string, :default => 'likes'

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), '../templates')
      end

      def create_migration
        migration_template 'likes_migration.rb', 'db/migrate/likes_migration.rb'
      end

      def create_model
        template "like.rb", File.join('app/models', "like.rb")
      end
    end
  end
end

