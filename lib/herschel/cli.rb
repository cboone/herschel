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

    flag [:d, :directory],
         arg_name: 'PATH',
         default_value: Dir.new(::Dir.pwd),
         type: Dir,
         desc: t('cli.flags.directory')

    pre do |global_options, command, options, args|
      set_log_level global_options[:verbose], global_options[:quiet]
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
