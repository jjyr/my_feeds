class Like < ActiveRecord::Base
  include MyFeeds::Associate

  init_feeds_polymorphic :likeable
  #attr_accessible

  belongs_to :likeable, polymorphic: true
end
