require 'spec_helper'

describe Herschel::Commands::Base do
  describe '.action' do
    subject { Herschel::Commands::Base.action }
    it { should == Herschel::Commands::Base.method(:run) }
  end

  describe '.run' do
    let(:arguments) { stub }
    let(:command) { stub }
    let(:global_options) { stub }
    let(:options) { stub }

    before do
      Herschel::Commands::Base.should_receive(:new).
        with(global_options, options, arguments).
        and_return(command)
      command.should_receive(:run)
    end

    specify { Herschel::Commands::Base.run global_options, options, arguments }
  end

  describe '#initialize' do
    let(:arguments) { stub }
    let(:directory) { stub }
    let(:global_options) { {directory: directory} }
    let(:options) { stub }

    subject { Herschel::Commands::Base.new global_options, options, arguments }

    its(:arguments) { should == arguments }
    its(:global_options) { should == global_options }
    its(:options) { should == options }
    its(:source_directory) { should == directory }
  end
end
