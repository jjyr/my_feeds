class User < ActiveRecord::Base
  attr_accessible :name
  has_many :posts
  has_many :likes

  include MyFeeds::Feeder
  include MyFeeds::Eater

  define_feed_event :write_post, target_type: Post.to_s
  define_feed_event :write_some_code

  def post title, content
    post = self.posts.create title: title, content: content
    write_post target_id: post.id
  end

  def feeds
    feeds_for likes
  end
end
