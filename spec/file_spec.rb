require 'spec_helper'

describe Herschel::File do
  describe '#path and #graph' do
    let(:file) { Tempfile.new 'herschel' }
    let(:path) { File.expand_path file.path }

    after do
      file.close
      file.unlink
    end

    subject { Herschel::File.new path }
    its(:path) { should == path }
    its(:graph) { should == path }
  end
end
