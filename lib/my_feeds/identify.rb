module MyFeeds
  module Identify
    extend ActiveSupport::Concern

    included do
      before_save :save_feed_identify
      init_feeds_polymorphic :source if self == Feed
      delegate :polymorphic_identify_column, :polymorphic_id_column, :polymorphic_type_column, to: :"self.class"
    end

    module ClassMethods
      def feed_polymorphic
        @_feed_polymorphic
      end

      def init_feeds_polymorphic polymorphic
        @_feed_polymorphic = polymorphic
        class_eval %Q{
          def save_feed_identify
            self.#{polymorphic_identify_column} = "#\{#{polymorphic_id_column}.to_s\}:#\{#{polymorphic_type_column}.to_s.underscore\}"
          end
          protected :save_feed_identify
        }
      end

      # def default_feed_polymorphic
      #   self.to_s.underscore
      # end

      def polymorphic_identify_column
        :"#{feed_polymorphic}_identify"
      end

      def polymorphic_id_column
        :"#{feed_polymorphic}_id"
      end

      def polymorphic_type_column
        :"#{feed_polymorphic}_type"
      end
    end
  end
end
