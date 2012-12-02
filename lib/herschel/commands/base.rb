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

      attr_reader :source_directory, :target_directory, :template_directory
      attr_accessor :arguments, :global_options, :options

      def initialize(global_options, options, arguments)
        @global_options = global_options
        @source_directory = global_options[:d]
        @target_directory = global_options[:'output-directory']
        @template_directory = global_options[:'template-directory']
        @options = options
        @arguments = arguments
      end
    end
  end
end
