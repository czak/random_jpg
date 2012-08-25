require "net/http"
require "json"

module RandomJpg
  class Loader::Imgur < Loader
    API_URL = "http://imgur.com/gallery/random.json"

    def next_image_url
      json = Net::HTTP.get URI(API_URL)
      hash = JSON.parse json
      image = hash["gallery"].select { |i| i["mimetype"] == "image/jpeg"}.first
      "http://i.imgur.com/#{image["hash"]}.jpg"
    end
  end
end
