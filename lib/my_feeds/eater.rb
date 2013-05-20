module MyFeeds
  module Eater
    extend ActiveSupport::Concern

    def feeds_for scope
      Feed.where source_identity: scope.select(scope.klass.polymorphic_identity_column)
    end
  end
end
