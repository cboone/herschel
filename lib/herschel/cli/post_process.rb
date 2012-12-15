module Herschel
  class CLI
    module PostProcess
      def post_process
        post do |global_options, command, options, arguments|
          global_options[:file_system].clean_up
        end
      end
    end
  end
end
