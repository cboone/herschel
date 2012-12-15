require 'herschel'

module Herschel
  class Command < Application::Base
    attr_reader :arguments, :commands, :file_system, :global_options, :options

    def initialize(*commands)
      @commands = commands.map do |command|
        command.to_s.sub('-', '_').to_sym
      end
    end

    def action
      method :run
    end

    def run(global_options, options, arguments)
      @global_options = go = global_options
      @options = options
      @arguments = arguments

      @global_options[:file_system] =
        @file_system = FileSystem.new directory_template: go[:'directory-template'],
                                      image_template: go[:'image-template'],
                                      root_template: go[:'root-template'],
                                      source_directory: go[:d],
                                      target_directory: go[:'output-directory'],
                                      template_directory: go[:'template-directory']

      #debug_options
      @commands.each do |command|
        send command
      end
    end

    def analyze
      analyze_templates
    end

    def analyze_templates
      info file_system.templates.inspect
    end

    def debug_options
      debug "global options:     #{global_options.inspect}"
      #debug ""
      #debug "configuration:      #{global_options[:c]}"
      #debug "source directory:   #{source_directory}"
      #debug "target directory:   #{target_directory}"
      #debug "template directory: #{template_directory}"
      #debug "working directory:  #{working_directory}"
      #debug ""
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
