require 'herschel'

module Herschel
  class CLI
    extend GLI::App
    include Methadone::CLILogging
    extend I18n
    include I18n
    extend Logging
    extend Argv
    extend CLI::Switches
    extend CLI::Flags

    setup_switches
    setup_flags


    desc t('cli.commands.analyze.description')
    command :analyze do |c|
      c.action &Commands::Analyze.action
    end

    pre do |global_options, command, options, arguments|
      global_options.tap do |go|
        simplify_options! go
        set_log_level go[:v], go[:q]
        process_accepts! go

        go[:file_system] = FileSystem.new image_types: go[:'image-types']
        go[:d].file_system = go[:file_system]
      end
    end

    accept Array do |string|
      string.split(',')
    end

    accept Directory do |path|
      Directory.new path
    end

    accept Pathname do |path|
      Pathname.new ::File.expand_path path
    end

    on_error do |exception|
      debug "#{exception.class}: #{exception.to_s}"
      debug exception.backtrace.join("\n")
      false
    end

    program_desc t('cli.description')

    @version = Herschel::VERSION
    switch :version,
           negatable: false,
           desc: t('cli.switches.version')
  end
end
