# RandomJpg

RandomJpg is a tool for easy downloading random images for use in scripts, application test data etc.
It runs silently in the background feeding random [Flickr](http://www.flickr.com) images to a [named pipe](http://en.wikipedia.org/wiki/Named_pipe) at a specified location, by default `/tmp/random.jpg`. By using a constant location, this simplifies a number of tasks related to downloading images.

## Installation

Install using:

    $ gem install random_jpg

## Requirements

[![Build Status](https://secure.travis-ci.org/czak/random_jpg.png?branch=master)](http://travis-ci.org/czak/random_jpg)


RandomJpg is verified to run under:

* Ruby 1.9.2
* Ruby 1.9.3

I'm using OS X and believe any Unix-based system will work.
I don't expect it to work under Windows, since I'm using `mkfifo` internally.

## Usage

Typical scenario: run once, use everywhere.

    $ random_jpg --daemon

This creates the pipe at the default location `/tmp/random.jpg`. Now you can download 3 random images to `~/Desktop` using:

    $ cp /tmp/random.jpg ~/Desktop/a.jpg
    $ cp /tmp/random.jpg ~/Desktop/b.jpg
    $ cp /tmp/random.jpg ~/Desktop/c.jpg

Or you can use it for seed data in loops:

```ruby
10.times do
  post = Post.new
  post.title = Faker::Lorem.words
  post.image = File.open('/tmp/random.jpg')
  post.save!
end
```

On each run, a new image will be downloaded and served.

## Info

RandomJpg &copy; 2012 Łukasz Adamczak, read LICENSE file for details.
