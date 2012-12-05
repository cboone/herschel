require 'herschel'

module Herschel
  module Logging
    attr_accessor :log_level

    def set_log_level verbose = nil, quiet = nil
      if verbose || quiet
        level = Methadone::CLILogger::FATAL if quiet
        level = Methadone::CLILogger::DEBUG if verbose
        self.log_level = self.logger.level = level
      end
    end
  end
end
