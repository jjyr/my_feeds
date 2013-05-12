module MyFeeds
  module Identify
    extend ActiveSupport::Concern

    included do
      before_save :save_feed_identify
      self.feed_polymorphic_name = self == Feed ? :source : default_feed_polymorphic_name
      delegate :default_feed_polymorphic_name, :polymorphic_identify_column, :polymorphic_id_column, :polymorphic_type_column, to: :"self.class"
    end

    module ClassMethods
      def feed_polymorphic_name
        @_feed_polymorphic_name
      end

      def feed_polymorphic_name= polymorphic_name
        @_feed_polymorphic_name = polymorphic_name
        class_eval %Q{
          def save_feed_identify
            self.#{polymorphic_identify_column} = "#\{#{polymorphic_id_column}.to_s\}@#\{#{polymorphic_type_column}.to_s.underscore\}"
          end
          protected :save_feed_identify
        }
      end

      def default_feed_polymorphic_name
        self.to_s.underscore
      end

      def polymorphic_identify_column
        :"#{feed_polymorphic_name}_identify"
      end

      def polymorphic_id_column
        :"#{feed_polymorphic_name}_id"
      end

      def polymorphic_type_column
        :"#{feed_polymorphic_name}_type"
      end
    end
  end
end
