require "net/http"
require "json"

module RandomJpg
  class Loader::Flickr < Loader
    API_URL = "http://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=66c61b93c4723c7c3a3c519728eac252&per_page=1&extras=url_m&format=json"

    def next_image_url
      json = Net::HTTP.get URI(API_URL)
      hash = JSON.parse json[14..-2]
      hash["photos"]["photo"].first["url_m"]
    end
  end
end
