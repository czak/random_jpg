require "optparse"

module RandomJpg
  class Runner
    def self.run(args)
      new(args).run
    end

    def initialize(args = [])
      @path = "/tmp/random.jpg"
      @daemon = false

      opts = OptionParser.new
      opts.banner = "Usage: random_jpg [options]\n\n"
      opts.separator "Options:"
      opts.on("-d", "--daemon", "Run in the background") do
        @daemon = true
      end
      opts.on("-p", "--path PATH", "Full path to the random image file") do |path|
        @path = path
      end
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
      opts.parse!(args)
    end

    def run
      create_pipe(@path)
      Process.daemon if @daemon
      trap("SIGINT") { File.unlink(@path); exit }
      loop { sleep 10 }
    end

    def create_pipe(path)
      system "mkfifo #{path}" or raise "Unable to create pipe: #{path}"
    end
  end
end
