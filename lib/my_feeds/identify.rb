module MyFeeds
  module Identify
    extend ActiveSupport::Concern

    included do
      before_save :save_feed_indentify
      class_attribute :feed_polymorphic_name
      self.feed_polymorphic_name = default_feed_polymorphic_name
      delegate :default_feed_polymorphic_name, :polymorphic_indentify_column, :polymorphic_id_column, :polymorphic_type_column, to: :class
    end

    protected
    def save_feed_indentify
      instance_eval %Q{self.#{polymorphic_indentify_column} = #{polymorphic_id_column}.to_s + #{polymorphic_type_column}.to_s.underscore}
    end

    private
    module ClassMethods
      def default_feed_polymorphic_name
        self.to_s.underscore
      end

      def polymorphic_indentify_column
        "#{feed_polymorphic_name}_indentify"
      end

      def polymorphic_id_column
        "#{feed_polymorphic_name}_id"
      end

      def polymorphic_type_column
        "#{feed_polymorphic_name}_type"
      end
    end
  end
end
