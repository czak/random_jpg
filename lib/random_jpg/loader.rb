require "net/http"
require "json"

module RandomJpg
  class Loader
    API_URL = "http://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=66c61b93c4723c7c3a3c519728eac252&per_page=1&extras=url_m&format=json"

    def feed(path)
      response = Net::HTTP.get URI(API_URL)
      hash = JSON.parse response[14..-2]
      image_data = Net::HTTP.get URI(hash["photos"]["photo"].first["url_m"])

      File.open(path, "w") do |f|
        f.write image_data
      end
    end
  end
end
