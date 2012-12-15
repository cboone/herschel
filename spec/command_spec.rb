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

    let(:directory) { stub }
    let(:directory_template) { stub }
    let(:image_template) { stub }
    let(:root_template) { stub }
    let(:output_directory) { stub }
    let(:template_directory) { stub }
    let(:working_directory) { stub }

    let(:global_options) { {
      d: directory,
      :'directory-template' => directory_template,
      :'image-template' => image_template,
      :'root-template' => root_template,
      :'output-directory' => output_directory,
      :'template-directory' => template_directory
    } }
    let(:options) { stub }
    let(:arguments) { stub }

    let(:file_system) { stub }
    let(:file_system_options) { {
      directory_template: directory_template,
      image_template: image_template,
      root_template: root_template,
      source_directory: directory,
      target_directory: output_directory,
      template_directory: template_directory
    } }

    before do
      command.should_receive :debug_options
      command.should_receive :analyze

      Herschel::FileSystem.stub(:new).with(file_system_options).and_return(file_system)

      command.run global_options, options, arguments
    end

    subject { command }

    its(:arguments) { should == arguments }
    its(:global_options) { should == global_options.merge(file_system: file_system) }
    its(:options) { should == options }
    its(:file_system) { should == file_system }
  end

  describe '#debug_options' do
    pending
  end

  describe '#analyze' do
    pending
  end

  #describe '#compile' do
  #  let(:command) { Herschel::Command.new :compile }
  #  let(:file_system) { stub }
  #
  #  before do
  #    Herschel::FileSystem.stub(:new).with(any_args).and_return(file_system)
  #    file_system.should_receive :compile
  #  end
  #
  #  specify { command.run({}, {}, {}) }
  #end

  describe Herschel::Command::Setup do
    describe '#declare_command' do
    end
  end
end
