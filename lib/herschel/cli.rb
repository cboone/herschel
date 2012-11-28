require 'herschel'

module Herschel
  class CLI
    extend GLI::App
    include Methadone::CLILogging

    class << self
      attr_accessor :log_level
    end

    switch [:v, :verbose],
           negatable: false,
           desc: 'Verbose mode'
    switch [:q, :quiet],
           negatable: false,
           desc: 'Quiet mode'

    pre do |global_options, command, options, args|
      set_log_level global_options[:verbose], global_options[:quiet]
    end

    def self.set_log_level verbose = nil, quiet = nil
      if verbose || quiet
        level = Methadone::CLILogger::FATAL if quiet
        level = Methadone::CLILogger::DEBUG if verbose
        @log_level = logger.level = level
      end
    end

    program_desc ''

    @version = Herschel::VERSION
    switch :version,
           negatable: false,
           desc: 'Display the current version number'
  end
end
