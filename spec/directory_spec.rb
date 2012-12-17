require 'spec_helper'

describe Herschel::Directory do
  describe '#absolute_url_path' do
    pending
  end

  describe '#children' do
    pending
  end

  describe '#compiled' do
    pending
  end

  describe '#directories' do
    pending
  end

  describe '#file_system' do
    let(:file_system) { stub }

    subject { directory.file_system }

    context 'when given a file system' do
      let(:directory) { Herschel::Directory.new '~', file_system: file_system }
      it { should == file_system }
    end

    context 'when not given a file system' do
      let(:directory) { Herschel::Directory.new '~' }
      it { should be_nil }
    end
  end

  describe '#images' do
    pending
  end

  describe '#meta' do
    pending
  end

  describe '#name' do
    pending
  end

  describe '#path' do
    let(:path) { './fixtures' }
    let(:expanded_path) { File.expand_path path }

    subject { Herschel::Directory.new(path).path }

    it { should be_a Pathname }
    its(:to_s) { should == expanded_path }
  end

  describe '#relative_path' do
    pending
  end

  describe '#rendering_scope' do
    pending
  end

  describe '#root' do
    subject { directory.root }

    context 'when the directory is given a root' do
      let(:root) { stub }
      let(:directory) { Herschel::Directory.new './fixtures', root: root }

      it { should == root }
    end

    context 'when the directory is not given a root' do
      let(:directory) { Herschel::Directory.new './fixtures' }

      it { should == directory }
    end
  end

  describe '#root?' do
    pending
  end

  describe '#template' do
    context 'when passed a file name' do
      let(:file_system) { Herschel::FileSystem.new }
      let(:template_name) { 'templates/root.html.slim' }

      subject { directory.template template_name }

      context 'when no template with the specified name exists' do
        let(:directory) { Herschel::Directory.new '/tmp', file_system: file_system }

        it { should be_nil }
      end

      context 'when a template with the specified name exists' do
        let(:directory) do
          path = File.dirname(__FILE__) + '/fixtures'
          Herschel::Directory.new path, file_system: file_system
        end

        its('relative_path.to_s') { should == 'templates/root.html.slim' }
      end
    end

    context 'when not passed a file name' do
      pending
    end
  end

  describe '#templates' do
    pending
  end

  describe '#to_s' do
    let(:path) { './fixtures' }
    let(:expanded_path) { File.expand_path path }

    subject { Herschel::Directory.new(path).to_s }

    it { should be_a String }
    it { should == expanded_path }
  end
end
