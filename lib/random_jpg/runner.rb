require "optparse"

module RandomJpg
  class Runner
    attr_reader :path, :daemon, :force, :loader

    def initialize(args = [])
      @path   = "/tmp/random.jpg"
      @daemon = false
      @force  = false
      @loader = Loader::Flickr.new
      parse_options(args)
    end

    def parse_options(args)
      OptionParser.new do |opts|
        opts.banner = "Usage: random_jpg [options]"
        opts.separator ""
        opts.separator "Options:"
        opts.on("-p", "--path PATH", "Full path to the random image file") do |path|
          @path = path
        end
        opts.on("-d", "--daemon", "Run in the background") do
          @daemon = true
        end
        opts.on("-f", "--force", "Force overwrite if a file exists at given path") do
          @force = true
        end
        opts.on("-l LOADER", [:flickr, :imgur], "Image source (flickr [default], imgur)") do |loader|
          @loader = Loader::Imgur.new if loader == :imgur
        end
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end.parse!(args)
    end

    def run
      create_pipe(@path, @force)
      Process.daemon if @daemon
      trap("SIGINT") { File.unlink(@path); exit }
      loop { @loader.feed(@path) }
    end

    def create_pipe(path, force = false)
      if File.exists?(path)
        if force
          raise Error.new("Permission denied: #{path}") unless File.writable?(path)
          File.unlink(path)
        else
          raise Error.new("Unable to create pipe: #{path}, file exists. Use --force to overwrite.")
        end
      end

      system "mkfifo #{path}"
    end
  end
end
