require "my_feeds/version"

module MyFeeds
  autoload :Feeder, 'my_feeds/feeder'
  autoload :Eater, 'my_feeds/eater'
  autoload :Identify, 'my_feeds/identify'
  
  #alias
  Associate = Identify
end
