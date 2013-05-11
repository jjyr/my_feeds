module MyFeeds
  module Eater
    extend ActiveSupport::Concern

    def feeds_for scope
      Feed.where source_identify: scope.select(scope.klass.polymorphic_identify_column)
    end
  end
end
