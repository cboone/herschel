require 'spec_helper'

describe Herschel::File do
  describe '#path, #graph, and #to_s' do
    let(:file) { Tempfile.new 'herschel' }
    let(:path) { File.expand_path file.path }

    after do
      file.close
      file.unlink
    end

    subject { Herschel::File.new path }
    its(:path) { should == path }
    its(:graph) { should == path }
    its(:to_s) { should == path }
  end

  describe '#file_system' do
    let(:file) { Tempfile.new 'herschel' }
    let(:path) { File.expand_path file.path }

    after do
      file.close
      file.unlink
    end

    context 'when given a file system' do
      let(:file_system) { Herschel::FileSystem.new }
      subject { Herschel::File.new path, file_system: file_system }
      its(:file_system) { should == file_system }
    end

    context 'when not given a file system' do
      subject { Herschel::File.new path }
      its(:file_system) { should be_a Herschel::FileSystem }
    end
  end
end
