require 'spec_helper'

describe Herschel::File do
  describe '#file_system' do
    let(:file_system) { stub }
    subject { Herschel::File.new './fixtures/file', file_system: file_system }
    its(:file_system) { should == file_system }
  end

  describe '#path' do
    let(:path) { './fixtures/file' }
    let(:expanded_path) { File.expand_path path }

    subject { Herschel::File.new(path).path }

    it { should be_a Pathname }
    its(:to_s) { should == expanded_path }
  end

  describe '#relative_path' do
    let(:root) { Herschel::Directory.new './fixtures', file_system: stub.as_null_object }
    let(:file) { Herschel::File.new './fixtures/directory_one/file', root: root }

    subject { file.relative_path }
    it { should be_a Pathname }
    its(:to_s) { should == 'directory_one/file' }
  end

  describe '#root' do
    let(:root) { stub }
    subject { Herschel::File.new './fixtures/file', root: root }
    its(:root) { should == root }
  end

  describe '#to_s' do
    let(:path) { './fixtures/file' }
    let(:expanded_path) { File.expand_path path }

    subject { Herschel::File.new(path).to_s }

    it { should be_a String }
    it { should == expanded_path }
  end
end
