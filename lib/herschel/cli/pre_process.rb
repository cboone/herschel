module Herschel
  class CLI
    module PreProcess
      include Logging
      include Argv

      def pre_process
        pre do |global_options, command, options, arguments|
          global_options.tap do |go|
            simplify_options! go
            set_log_level go[:v], go[:q]
            process_accepts! go
          end
        end
      end
    end
  end
end
