class Like < ActiveRecord::Base
  include MyFeeds::Identify
  self.feed_polymorphic = :likeable
  #attr_accessible

  belongs_to :likeable, polymorphic: true
end
