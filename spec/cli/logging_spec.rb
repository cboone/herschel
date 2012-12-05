require 'spec_helper'

describe Herschel::Logging do
  describe '.set_log_level' do
    let(:logger) { double.stub(:level=) }
    let(:default) { Methadone::CLILogger::INFO }
    let(:quiet) { Methadone::CLILogger::FATAL }
    let(:verbose) { Methadone::CLILogger::DEBUG }
    let(:cli) { double(logger: logger, :log_level= => nil) }

    before { cli.extend Herschel::Logging }

    subject { cli.log_level }

    context 'when told nothing' do
      before do
        logger.should_not_receive(:level=)
        cli.should_not_receive(:log_level=)
      end

      specify { cli.set_log_level }
    end

    context 'when told to use verbose mode' do
      before do
        logger.should_receive(:level=).with(verbose)
        cli.should_receive(:log_level=).with(verbose)
      end

      specify { cli.set_log_level true }
    end

    context 'when told to use quiet mode' do
      before do
        logger.should_receive(:level=).with(quiet)
        cli.should_receive(:log_level=).with(quiet)
      end

      specify { cli.set_log_level nil, true }
    end

    context 'when told to use verbose and quiet mode' do
      before do
        logger.should_receive(:level=).with(verbose)
        cli.should_receive(:log_level=).with(verbose)
      end

      specify { cli.set_log_level true, true }
    end
  end
end
