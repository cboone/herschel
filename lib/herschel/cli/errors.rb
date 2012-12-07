module Herschel
  class CLI
    module Errors
      def handle_errors
        on_error do |exception|
          debug "#{exception.class}: #{exception.to_s}"
          debug exception.backtrace.join("\n")
          false
        end
      end
    end
  end
end
