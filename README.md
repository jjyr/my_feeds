# MyFeeds

Help you implement feeds / timeline in rails application.

## Installation

Add this line to your application's Gemfile:

    gem 'my_feeds'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install my_feeds

## Usage


####before usage
my_feeds need `feeder`, `eater` and associate model

feeder publish feeds

eater receive publish

and associate model create a relation between feeder and eater

yes, like subscribe and publish

####feed model
feed model is what feeder published and  eater subscribed, you can customize it.

`rails generate my_feeds`

####associate model

`rails generate my_feeds:likes`
#####use own associate model
you can also use your own associate model.

just make sure your model have a polymorphic field for feeder.

and
```
class YourCustomModel < ActiveRecord::Base
  include MyFeeds::Associate #make sure include this module
  self.feed_polymorphic = :likeable #and set this, in this case is likeable, it should same as the polymorphic belongs_to

  #same as self.feed_polymorphic
  belongs_to :likeable, polymorphic: true
end

# you should create a migration like below
# in this case, this column name is likeable_identify, it depends on feed_polymorphic
#add_column :your_customs, :likeable_identify, :string, null: false
```

####feeder

include MyFeeds::Feeder in your model which will as feed source

```ruby
class User < ActiveRecord::Base
  ...
  include MyFeeds::Feeder
  ...
end
```

now `User` get a method `define_feed_event`

use `define_feed_event` define your feed_event
```ruby
class User < ActiveRecord::Base
  ...
  include MyFeeds::Feeder

  define_feed_event :hahahaha
  define_feed_event :kakakaka
  ...
end

#in you rails console
user = User.create ...

#user get a method hahahaha...
#will create 3 feeds
user.hahahaha
user.hahahaha
user.hahahaha

#you can use source_feeds associate fetch your source feeds
user.source_feeds.count  #=> 3

#or scoped version
user.hahahaha_feeds.count #=> 3
user.kakakaka_feeds.count #=> 0

#you can pass extra arguments to feed_event method, but must match feed model attributes
user.hahahaha target_id: another_user.id, target_type: another_user.class

user.source_feeds.last.target_id #=> another_user.id

#you can also passed arguments with define_feed_event, then arguments will be default
...
  define_feed_event :hahahaha, target_type: User
...

user.hahahaha target_id: another_user.id
user.source_feeds.last.target_type #=> User
```

####eater
include MyFeeds::Eater in your model which will as feed receiver

```ruby
class User < ActiveRecord::Base
  ...
  include MyFeeds::Eater
  has_many :likes #a eater must have associate with feeder

  def feeds
    #eater have method feeds_for, pass associate and return feeds
    feeds_for likes
  end
  ...
end

##sample
#create relation
u = User.create
like = u.likes.new
like.likeable = another_user
like.save
like = u.likes.new
like.likeable = Post.find ...
like.save
u.feeds #=> you get feeds


##feeds with scope??
class User < ActiveRecord::Base
  ...
  include MyFeeds::Eater
  has_many :likes #a eater must have associate with feeder

  def feeds
    #eater have method feeds_for, pass associate and return feeds
    feeds_for likes
  end

  def teams_feeds
    feeds_for likes.where(likeable_type: Team)
  end

  def users_posts_feeds
    feeds_for(likes.where likeable_type: User).where(target_type: Post)
  end
  ...
end
```

## Contributing


1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
