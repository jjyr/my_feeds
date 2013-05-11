class Like < ActiveRecord::Base
  include MyFeeds::Identify
  self.feed_polymorphic_name = :likeable
  #attr_accessible

  belongs_to :likeable, polymorphic: true
end
