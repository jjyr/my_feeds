# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'my_feeds/version'

Gem::Specification.new do |spec|
  spec.name          = "my_feeds"
  spec.version       = MyFeeds::VERSION
  spec.authors       = ["jjy"]
  spec.email         = ["jjyruby@gmail.com"]
  spec.description   = %q{Help you implement feeds / timeline / public activity in rails application.}
  spec.summary       = %q{my_feeds provide feed model and some helper methods, allow you to customize.}
  spec.homepage      = "https://github.com/jjyr/my_feeds"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
