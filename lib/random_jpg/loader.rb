require "net/http"
require "uri"

module RandomJpg
  class Loader
    def next_image_url
      raise NoMethodError.new("Implement RandomJpg::Loader#next_image_url in a subclass.")
    end

    def next_image_data
      response = Net::HTTP.get_response URI(next_image_url)
      raise DownloadError.new("Image download failed.") unless response.kind_of?(Net::HTTPSuccess)
      response.body  
    end
    
    def feed(path)
      File.write path, next_image_data
    end
  end
end
