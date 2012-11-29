require 'herschel'

module Herschel
  module Commands
    class Base < Application::Base
      def self.action
        method :run
      end

      def self.run(global_options, options, arguments)
        self.new(global_options, options, arguments).run
      end

      attr_accessor :global_options, :options, :arguments

      def initialize(global_options, options, arguments)
        @global_options = global_options
        @options = options
        @arguments = arguments
      end
    end
  end
end
