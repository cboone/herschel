require 'herschel'

module Herschel
  class CLI
    include GLI::App
    include Methadone::CLILogging
    include I18n
    include Accepts
    include Errors
    include Flags
    include Preprocess
    include Switches
    include Version

    attr_reader :config_file

    def initialize(config_file_path)
      @config_file = config_file_path

      declare_acceptable_classes
      declare_global_flags
      declare_global_switches
      declare_version
      handle_errors
      preprocess
      program_desc t('cli.description')

      desc t('cli.commands.analyze.description')
      command :analyze do |c|
        c.action &Commands::Analyze.action
      end
    end
  end
end
