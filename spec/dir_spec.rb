require 'spec_helper'

describe Herschel::Dir do
  describe '#path' do
    let(:path) { File.expand_path '~' }
    subject { Herschel::Dir.new '~' }
    its(:path) { should == path }
  end

  describe '#each' do
    let(:first_child) { 'first child' }
    let(:second_child) { 'second child' }
    let(:dir) { Herschel::Dir.new '/tmp' }

    before do
      Pathname.any_instance.stub(:each_child).and_return do |&block|
        [first_child, second_child].each do |child|
          block.call child
        end
      end
      Herschel::FileSystem.should_receive(:new_file_or_dir).with(first_child).and_return(first_child)
      Herschel::FileSystem.should_receive(:new_file_or_dir).with(second_child).and_return(second_child)
    end

    subject { dir.map &:to_s }
    it { should == ['first child', 'second child'] }
  end

  describe '#graph' do
    let(:dir) { Herschel::Dir.new './fixtures/graph' }
    before do
      dir.stub(:each).and_yield stub(graph: 'children')
    end

    subject { dir.graph }

    its(:first) { should =~ /\/graph$/ }
    its(:last){should == ['children'] }
  end
end
