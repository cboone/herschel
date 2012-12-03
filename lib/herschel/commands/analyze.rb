require 'herschel'

module Herschel
  module Commands
    class Analyze < Base
      def run
        debug "global options:     #{global_options.inspect}"
        debug ""
        debug "configuration:      #{global_options[:c]}"
        debug "source directory:   #{source_directory}"
        debug "target directory:   #{target_directory}"
        debug "template directory: #{template_directory}"
        debug "working directory:  #{working_directory}"
        debug ""
        info source_directory.graph.join("\n")
      end
    end
  end
end
