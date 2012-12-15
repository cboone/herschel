require 'spec_helper'

describe Herschel::WorkingDirectory do
  describe '#initialize' do
    subject { Herschel::WorkingDirectory.new }
    its(:to_s) { should =~ /herschel-.*-working$/ }
  end

  describe '#clean_up' do
    let(:directory) { Herschel::WorkingDirectory.new }
    let(:path) { directory.path }

    before do
      FileUtils.should_receive(:remove_entry_secure).with(path)
    end

    specify { directory.clean_up }
  end
end
