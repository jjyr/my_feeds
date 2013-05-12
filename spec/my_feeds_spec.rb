require 'spec_helper'

describe MyFeeds do
  before :all do
    @user1 = User.create name: 'jjyr'
    @user2 = User.create name: 'writer'
  end

  describe MyFeeds::Feeder do
    before :all do
      @user2.write_some_code
      @user2.post "i write a gem", "content is not important"
    end

    it "when call feed_event should create feed" do
      @user2.source_feeds.count.should == 2
      @user2.source_feeds.count.should == Feed.count
      @user2.source_feeds.first.event.should == 'write_some_code'
      @user2.source_feeds.last.event.should == 'write_post'
    end

    it "scope version source_feeds should work" do
      @user2.write_some_code_feeds.count.should == 1
      @user2.write_some_code_feeds.first.event.should == 'write_some_code'
      @user2.write_post_feeds.count.should == 1
      @user2.write_post_feeds.first.event.should == 'write_post'
      (@user2.write_post_feeds.count + @user2.write_some_code_feeds.count).should == @user2.source_feeds.count
    end
  end


  describe MyFeeds::Eater do
    before :all do
      @user1.feeds.count.should == 0
      like = @user1.likes.new
      like.likeable = @user2
      like.save!
    end

    it "should have some feeds" do
      @user1.feeds.count.should == Feed.count
    end

    it "feeds should change" do
      @user2.posts.first.update_attributes content: "update"
      @user1.feeds.count.should == Feed.count - 1
      like = @user1.likes.new
      like.likeable = @user2.posts.first
      like.save!
      @user1.feeds.count.should == Feed.count
    end

    it "scope should work" do
      @user1.feeds_for(@user1.likes.where likeable_type: Post.to_s).count.should == @user1.feeds.where(source_type: Post.to_s).count
      @user1.feeds_for(@user1.likes.where likeable_type: User.to_s).count.should == @user1.feeds.where(source_type: User.to_s).count
    end

    it "eater's feeds should match feeder's write_post_feeds" do
      post_feeds = @user2.write_post_feeds.to_a
      user_post_feeds = @user1.feeds.where(target_type: Post.to_s).to_a
      post_feeds.count.should == user_post_feeds.count
      user_post_feeds.each do |post|
        post_feeds.should include(post)
      end
    end
    
    it "eater's feeds should match feeder's write_some_code_feeds" do
      code_feeds = @user2.write_some_code_feeds.to_a
      user_feeds = @user1.feeds.where(event: 'write_some_code').to_a
      code_feeds.count.should == user_feeds.count
      user_feeds.each do |feed|
        code_feeds.should include(feed)
      end
    end
  end
end
