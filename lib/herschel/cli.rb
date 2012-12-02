require 'herschel'

module Herschel
  class CLI
    extend GLI::App
    include Methadone::CLILogging
    extend Herschel::I18n
    include Herschel::I18n

    class << self
      attr_accessor :log_level
    end

    switch [:v, :verbose],
           negatable: false,
           desc: t('cli.switches.verbose')
    switch [:q, :quiet],
           negatable: false,
           desc: t('cli.switches.quiet')

    flag [:a, :'allowed-file-extensions'],
         arg_name: 'EXT1[,EXT2..]',
         negatable: false,
         default_value: t('cli.flags.allowed-file-extensions.default'),
         type: Array,
         desc: t('cli.flags.allowed-file-extensions.description')
    flag [:d, :directory],
         arg_name: 'PATH',
         default_value: Dir.new(::Dir.pwd),
         type: Dir,
         desc: t('cli.flags.directory')
    flag [:c, :configuration],
         arg_name: 'PATH',
         negatable: false,
         default_value: './herschel.yml',
         desc: t('cli.flags.configuration')

    command :analyze do |c|
      c.desc t('cli.commands.analyze.description')
      c.action &Commands::Analyze.action
    end

    pre do |global_options, command, options, arguments|
      global_options.tap do |go|
        set_log_level go[:v], go[:q]

        go[:a] = go[:a].split(',') if go[:a].is_a? String
        go[:file_system] = FileSystem.new allowed: go[:a]
        go[:d] = Dir.new go[:d] if go[:d].is_a? String
        go[:d].file_system = go[:file_system]
      end
    end

    accept Array do |string|
      string.split(',')
    end

    accept Dir do |path|
      Dir.new path
    end

    def self.set_log_level verbose = nil, quiet = nil
      if verbose || quiet
        level = Methadone::CLILogger::FATAL if quiet
        level = Methadone::CLILogger::DEBUG if verbose
        @log_level = logger.level = level
      end
    end

    program_desc t('cli.description')

    @version = Herschel::VERSION
    switch :version,
           negatable: false,
           desc: t('cli.switches.version')
  end
end
