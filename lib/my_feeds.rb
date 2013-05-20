require "my_feeds/version"

module MyFeeds
  autoload :Feeder, 'my_feeds/feeder'
  autoload :Eater, 'my_feeds/eater'
  autoload :Identity, 'my_feeds/identity'
  
  #alias
  Associate = Identity
end
