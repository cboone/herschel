require 'spec_helper'

describe Herschel::Directory do
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

    context 'when given a file system after initialization' do
      let(:directory) { Herschel::Directory.new '~' }

      before { directory.file_system = file_system }

      it { should == file_system }
    end
  end

  describe '#images' do
    pending
  end

  describe '#parent' do
    subject { directory.parent }

    context 'when a parent is passed in' do
      let(:parent) { stub }
      let(:directory) { Herschel::Directory.new '/tmp', parent: parent }

      it { should == parent }
    end

    context 'when a parent is not passed in' do
      let(:directory) { Herschel::Directory.new '/tmp' }

      it { should be_nil }
    end
  end

  describe '#path' do
    let(:path) { './fixtures' }
    let(:expanded_path) { File.expand_path path }

    subject { Herschel::Directory.new(path).path }

    it { should be_a Pathname }
    its(:to_s) { should == expanded_path }
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

  describe '#to_s' do
    let(:path) { './fixtures' }
    let(:expanded_path) { File.expand_path path }

    subject { Herschel::Directory.new(path).to_s }

    it { should be_a String }
    it { should == expanded_path }
  end

  describe '#template' do
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

  describe '#templates' do
    pending
  end

  #describe '#file' do
  #  let(:directory) { Herschel::Directory.new '/tmp' }
  #  let(:file_name) { 'file.html' }
  #
  #  before { directory.stub(:files).and_return(files) }
  #
  #  subject { directory.file file_name }
  #
  #  context 'when the specified file exists' do
  #    let(:file) { stub }
  #    let(:files) { {file_name => file} }
  #
  #    it { should == file }
  #  end
  #
  #  context 'when the specified file does not exist' do
  #    let(:files) { {} }
  #
  #    it { should be_nil }
  #  end
  #end
  #
  #describe '#each' do
  #  let(:file_system) { Herschel::FileSystem.new }
  #  let(:first_child) { 'first child' }
  #  let(:second_child) { 'second child' }
  #  let(:dir) { Herschel::Directory.new '/tmp', file_system: file_system }
  #
  #  before do
  #    Pathname.any_instance.stub(:each_child).and_return do |&block|
  #      [first_child, second_child].each do |child|
  #        block.call child
  #      end
  #    end
  #    file_system.stub(:new_file_or_dir).with(first_child).and_return(first_child)
  #    file_system.stub(:new_file_or_dir).with(second_child).and_return(second_child)
  #  end
  #
  #  subject { dir.map &:to_s }
  #  it { should == ['first child', 'second child'] }
  #end
  #
  #describe '#graph' do
  #  let(:dir) { Herschel::Directory.new './fixtures/graph' }
  #  before do
  #    dir.stub(:each).and_yield stub(graph: 'children')
  #  end
  #
  #  subject { dir.graph }
  #
  #  its(:first) { should =~ /\/graph$/ }
  #  its(:last) { should == ['children'] }
  #end
end
