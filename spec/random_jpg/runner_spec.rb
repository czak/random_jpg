require "spec_helper"

module RandomJpg
  describe Runner do
    describe "#create_pipe(path)" do
      let(:path) { "/tmp/fullpath.jpg" }

      it "creates a named pipe and returns true" do
        subject.should_receive(:system).with("mkfifo #{path}").and_return(true)
        subject.create_pipe(path).should be_true
      end

      context "when the system call fails" do
        before { subject.stub :system => false }
        it "raises an error" do
          expect {
            subject.create_pipe(path)
          }.to raise_error
        end
      end
    end
  end
end
