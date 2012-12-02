require 'herschel'

module Herschel
  class CLI
    module Support
      def simplify_options(options, *canonical_options)
        allowed_keys = canonical_options.map(&:keys).flatten
        options.select! { |key| allowed_keys.include? key }
      end

      def set_log_level verbose = nil, quiet = nil
        if verbose || quiet
          level = Methadone::CLILogger::FATAL if quiet
          level = Methadone::CLILogger::DEBUG if verbose
          @log_level = logger.level = level
        end
      end
    end
  end
end
