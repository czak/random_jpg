require "net/http"
require "json"

module RandomJpg
  module Loader
    class Imgur
      API_URL = "http://imgur.com/gallery/random.json"

      def feed(path)
        response = Net::HTTP.get URI(API_URL)
        hash = JSON.parse response
        image = hash["gallery"].select { |i| i["mimetype"] == "image/jpeg"}.first
        image_data = Net::HTTP.get URI("http://i.imgur.com/#{image["hash"]}.jpg")

        File.open(path, "w") do |f|
          f.write image_data
        end
      end
    end
  end
end
