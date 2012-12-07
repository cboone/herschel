require 'herschel'

module Herschel
  class Command < Application::Base
    attr_reader :arguments, :commands, :global_options, :options,
                :source_directory, :target_directory, :template_directory,
                :working_directory

    def initialize(*commands)
      @commands = commands.map do |command|
        command.to_s.sub('-', '_').to_sym
      end
    end

    def action
      method :run
    end

    def run(global_options, options, arguments)
      @global_options = global_options
      @source_directory = global_options[:d]
      @target_directory = global_options[:'output-directory']
      @template_directory = global_options[:'template-directory']
      @working_directory = global_options[:'working-directory']
      @options = options
      @arguments = arguments

      @commands.each do |command|
        send command
      end
    end

    def analyze
      info source_directory.graph.join("\n")
    end

    def debug_options
      debug "global options:     #{global_options.inspect}"
      debug ""
      debug "configuration:      #{global_options[:c]}"
      debug "source directory:   #{source_directory}"
      debug "target directory:   #{target_directory}"
      debug "template directory: #{template_directory}"
      debug "working directory:  #{working_directory}"
      debug ""
    end

    module Setup
      def declare_command(command_name)
        desc t("cli.commands.#{command_name}.description")
        command command_name do |c|
          c.action &Command.new(command_name).action
        end
      end
    end
  end
end
