require "spec_helper"

module RandomJpg
  describe Runner do
    describe "#parse_options(args)" do
      context "-p" do
        it "requires an argument" do
          expect {
            subject.parse_options(["-p"])
          }.to raise_error(OptionParser::MissingArgument)
        end
      end

      context "-p some/path" do
        it "sets path to 'some/path'" do
          subject.parse_options(["-p", "some/path"])
          subject.path.should == "some/path"
        end
      end

      context "-d" do
        it "enables daemon mode" do
          subject.parse_options(["-d"])
          subject.daemon.should be_true
        end
      end

      context "-f" do
        it "enables force overwrite" do
          subject.parse_options(["-f"])
          subject.force.should be_true
        end
      end

      context "-l" do
        it "requires an argument" do
          expect {
            subject.parse_options(["-l"])
          }.to raise_error(OptionParser::MissingArgument)
        end

        it "only accepts arguments: flickr, imgur" do
          expect {
            subject.parse_options(["-l", "wrong_loader"])
          }.to raise_error(OptionParser::InvalidArgument)
        end
      end

      context "-l flickr" do
        it "enables the Flickr loader" do
          subject.parse_options(["-l", "flickr"])
          subject.loader.should be_an_instance_of Loader::Flickr
        end
      end

      context "-l imgur" do
        it "enables the Imgur loader" do
          subject.parse_options(["-l", "imgur"])
          subject.loader.should be_an_instance_of Loader::Imgur
        end
      end
    end
  end
end
