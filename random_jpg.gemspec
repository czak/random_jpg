# -*- encoding: utf-8 -*-
require File.expand_path('../lib/random_jpg/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Łukasz Adamczak"]
  gem.email         = ["lukasz@czak.pl"]
  gem.description   = %q{RandomJpg is a tool for easy downloading random images for use in scripts, application test data etc. It runs silently in the background feeding random Flickr images to a named pipe at a specified location, by default /tmp/random.jpg.}
  gem.summary       = %q{A command-line tool for easy downloading & reading random images from the web.}
  gem.homepage      = "https://github.com/czak/random_jpg"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "random_jpg"
  gem.require_paths = ["lib"]
  gem.version       = RandomJpg::VERSION
end
