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
      declare_command :compile

      if ENV['DEVELOPMENT']
        declare_command :'analyze-file-system'
        declare_command :'analyze-images'
        declare_command :'analyze-source'
        declare_command :'analyze-templates'
        declare_command :'compile-directories'
        declare_command :'compile-root'
        declare_command :'debug-options'
      end
    end
  end
end
