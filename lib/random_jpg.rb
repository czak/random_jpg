$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require "random_jpg/version"
require "random_jpg/error"
require "random_jpg/runner"
require "random_jpg/loader"
require "random_jpg/loader/flickr"
require "random_jpg/loader/imgur"
