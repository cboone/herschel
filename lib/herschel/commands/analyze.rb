require 'herschel'

module Herschel
  module Commands
    class Analyze < Base
      def run
        debug global_options.inspect
        info source_directory.graph.join("\n")
      end
    end
  end
end
