require 'spec_helper'

describe Herschel::CLI do
  describe '#initialize' do
    before do
      Herschel::CLI.any_instance.tap do |cli|
        cli.should_receive(:program_desc).with(I18n.t('herschel.cli.description'))
        cli.should_receive :declare_acceptable_classes
        cli.should_receive :declare_global_flags
        cli.should_receive :declare_global_switches
        cli.should_receive :declare_version
        cli.should_receive :handle_errors
        cli.should_receive :preprocess
      end
    end

    subject { Herschel::CLI.new 'config path' }
    its(:config_file) { should == 'config path' }
  end
end
