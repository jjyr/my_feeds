module MyFeeds
  module Eater
    extend ActiveSupport::Concern

    def feeds_for source_ids = :all, conditions = {}
      conditions.merge!(source_id: source_ids) if source_ids != :all
      Feed.where conditions
    end
  end
end
