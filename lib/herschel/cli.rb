require 'herschel'

module Herschel
  class CLI
    extend GLI::App
    include Methadone::CLILogging
    extend I18n
    include I18n
    extend Logging
    extend Argv
    extend Accepts
    extend Errors
    extend Flags
    extend Preprocess
    extend Switches
    extend Version

    program_desc t('cli.description')

    declare_acceptable_classes
    declare_global_flags
    declare_global_switches
    declare_version
    handle_errors
    preprocess

    desc t('cli.commands.analyze.description')
    command :analyze do |c|
      c.action &Commands::Analyze.action
    end
  end
end
