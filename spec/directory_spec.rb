require 'spec_helper'

describe Herschel::Directory do
  describe '#path and #to_s' do
    let(:path) { File.expand_path '~' }
    subject { Herschel::Directory.new '~' }
    its(:path) { should == path }
    its(:to_s) { should == path }
  end

  describe '#file_system' do
    let(:file_system) { Herschel::FileSystem.new }

    context 'when given a file system' do
      subject { Herschel::Directory.new '~', file_system: file_system }
      its(:file_system) { should == file_system }
    end

    context 'when not given a file system' do
      subject { Herschel::Directory.new '~' }
      its(:file_system) { should be_a Herschel::FileSystem }
    end

    context 'when given a file system after initialization' do
      let(:dir) { Herschel::Directory.new '~' }
      before { dir.file_system = file_system }
      subject { dir }
      its(:file_system) { should == file_system }
    end
  end

  describe '#each' do
    let(:file_system) { Herschel::FileSystem.new }
    let(:first_child) { 'first child' }
    let(:second_child) { 'second child' }
    let(:dir) { Herschel::Directory.new '/tmp', file_system: file_system }

    before do
      Pathname.any_instance.stub(:each_child).and_return do |&block|
        [first_child, second_child].each do |child|
          block.call child
        end
      end
      file_system.stub(:new_file_or_dir).with(first_child).and_return(first_child)
      file_system.stub(:new_file_or_dir).with(second_child).and_return(second_child)
    end

    subject { dir.map &:to_s }
    it { should == ['first child', 'second child'] }
  end

  describe '#graph' do
    let(:dir) { Herschel::Directory.new './fixtures/graph' }
    before do
      dir.stub(:each).and_yield stub(graph: 'children')
    end

    subject { dir.graph }

    its(:first) { should =~ /\/graph$/ }
    its(:last) { should == ['children'] }
  end
end
