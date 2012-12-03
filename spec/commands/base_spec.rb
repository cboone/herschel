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
    let(:output_directory) { stub }
    let(:template_directory) { stub }
    let(:working_directory) { stub }
    let(:global_options) { {
      d: directory,
      :'output-directory' => output_directory,
      :'template-directory' => template_directory,
      :'working-directory' => working_directory
    } }
    let(:options) { stub }

    subject { Herschel::Commands::Base.new global_options, options, arguments }

    its(:arguments) { should == arguments }
    its(:global_options) { should == global_options }
    its(:options) { should == options }
    its(:target_directory) { should == output_directory }
    its(:source_directory) { should == directory }
    its(:template_directory) { should == template_directory }
    its(:working_directory) { should == working_directory }
  end
end
