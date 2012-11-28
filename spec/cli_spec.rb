require 'spec_helper'

describe Herschel::CLI do
  let(:cli) { Herschel::CLI }

  describe '.set_log_level' do
    let(:logger) { Methadone::CLILogger.new }
    let(:default) { Methadone::CLILogger::INFO }
    let(:quiet) { Methadone::CLILogger::FATAL }
    let(:verbose) { Methadone::CLILogger::DEBUG }

    before do
      cli.log_level = nil
      cli.logger = logger
    end

    after do
      cli.instance_variable_set :@log_level, nil
      cli.logger = Methadone::CLILogger.new
    end

    context 'when told nothing' do
      before { cli.set_log_level }

      specify { cli.log_level.should be_nil }
      specify { cli.logger.level.should == default }
    end

    context 'when told to use verbose mode' do
      before { cli.set_log_level true }

      specify { cli.log_level.should == verbose }
      specify { cli.logger.level.should == verbose }
    end

    context 'when told to use quiet mode' do
      before { cli.set_log_level nil, true }

      specify { cli.log_level.should == quiet }
      specify { cli.logger.level.should == quiet }
    end

    context 'when told to use verbose and quiet mode' do
      before { cli.set_log_level true, true }

      specify { cli.log_level.should == verbose }
      specify { cli.logger.level.should == verbose }
    end
  end
end
