require 'herschel'

module Herschel
  class CLI
    include GLI::App
    include Methadone::CLILogging
    include I18n
    include Accepts
    include Command::Setup
    include Errors
    include Flags
    include PostProcess
    include PreProcess
    include Switches
    include Version

    attr_reader :config_file

    def initialize(config_file_path)
      @config_file = config_file_path

      program_desc t('cli.description')

      declare_acceptable_classes
      declare_global_flags
      declare_global_switches
      declare_version

      handle_errors
      pre_process
      post_process

      declare_command :analyze

      if ENV['DEVELOPMENT']
        declare_command :'debug-options'
        declare_command :'analyze-source'
        declare_command :'analyze-templates'
      end
    end
  end
end
