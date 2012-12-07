require 'spec_helper'

describe Herschel::Command do
  describe '#initialize' do
    context 'given one command' do
      subject { Herschel::Command.new :analyze }
      its(:commands) { should == [:analyze] }
    end

    context 'given multiple commands' do
      subject { Herschel::Command.new :'debug-options', :analyze }
      its(:commands) { should == [:debug_options, :analyze] }
    end
  end

  describe '#action' do
    let(:command) { Herschel::Command.new :analyze }
    before { command.should_receive :run }
    subject { command.action }
    specify { subject.call }
  end

  describe '#run' do
    let(:command) { Herschel::Command.new :debug_options, :analyze }

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

    before do
      command.should_receive :debug_options
      command.should_receive :analyze
      command.run global_options, options, arguments
    end

    subject { command }

    its(:arguments) { should == arguments }
    its(:global_options) { should == global_options }
    its(:options) { should == options }
    its(:target_directory) { should == output_directory }
    its(:source_directory) { should == directory }
    its(:template_directory) { should == template_directory }
    its(:working_directory) { should == working_directory }
  end

  describe '#debug_options' do
  end

  describe '#analyze' do
  end

  describe Herschel::Command::Setup do
    describe '#declare_command' do
    end
  end
end
