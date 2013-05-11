module MyFeeds
  module Feeder
    extend ActiveSupport::Concern

    included do
      has_many :source_feeds, class_name: Feed.to_s, as: :source, dependent: :destroy
    end

    module ClassMethods
      def define_feed_event event, conditions = {}
        conditions.freeze
        define_method(event) do |options = {}|
          attributes = {source_type: self.class.to_s, source_id: self.id, event: event}.merge!(conditions).merge! options
          Feed.create attributes
        end

        define_method("#{event}_feeds") do
          source_feeds.where({event: event}.merge! conditions)
        end
      end
    end
  end
end
