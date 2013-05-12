class Post < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :title

  include MyFeeds::Feeder

  define_feed_event :content_update

  before_update do
    content_update
  end
end
