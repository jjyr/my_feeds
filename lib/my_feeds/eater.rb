module MyFeeds
  module Eater
    extend ActiveSupport::Concern

    def feeds_for source_ids, feeder, *events
      conditions = {}
      conditions.merge! feeder.feeder_feed_events[event.to_sym]
      conditions.merge!(source_id: source_ids) if source_ids != :all
      Feed.where conditions
    end
  end
end
