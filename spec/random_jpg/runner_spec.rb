require "spec_helper"

module RandomJpg
  describe Runner do
    describe "#create_pipe(path, force = false)" do
      let(:path) { "/tmp/fullpath.jpg" }

      context "when no file exists at path" do
        before { File.stub :exists? => false }

        it "creates a named pipe and returns true" do
          subject.should_receive(:system).with("mkfifo #{path}").and_return(true)
          subject.create_pipe(path).should be_true
        end
      end

      context "when a file exists at path" do
        before { File.stub :exists? => true }

        context "and force = false" do
          it "raises a RandomJpg::Error" do
            expect {
              subject.create_pipe(path)
            }.to raise_error(RandomJpg::Error)
          end
        end

        context "and force = true" do
          context "when user has write access to file" do
            before { File.stub :writable? => true }

            it "unlinks the original file and creates the pipe" do
              File.should_receive(:unlink).with(path)
              subject.should_receive(:system).with("mkfifo #{path}").and_return(true)
              subject.create_pipe(path, true).should be_true
            end
          end

          context "but user has no permission to write to the file" do
            before { File.stub :writable? => false }

            it "raises RandomJpg::Error" do
              expect {
                subject.create_pipe(path, true)
              }.to raise_error(RandomJpg::Error)
            end
          end
        end
      end
    end
  end
end
