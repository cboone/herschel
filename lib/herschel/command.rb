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
        @file_system = FileSystem.new source_directory: go[:S],
                                      target_directory: go[:O],
                                      template_directory: go[:T],

                                      directory_template: go[:'directory-template'],
                                      image_template: go[:'image-template'],
                                      root_template: go[:'root-template'],

                                      image_types: go[:'image-types']

      debug_options unless @commands.include? :debug_options
      @commands.each do |command|
        send command
      end
    end

    def analyze
      analyze_templates
      analyze_source
    end

    def analyze_source
      header 'SOURCE'
      file_system.source_directory.tap do |source|
        info source.to_s
        source.directories.each do |directory|
          info directory.to_s
          directory.images.each do |image|
            info image.to_s
          end
        end
      end
    end

    def analyze_templates
      header 'TEMPLATES'
      info columns 'templates', file_system.template_directory.to_s
      file_system.templates.each do |name, file|
        info columns name, file.to_s
      end
    end

    def debug_options
      header 'GLOBAL OPTIONS'
      global_options.each do |option, value|
        debug columns option, value.inspect
      end
    end

    module Setup
      def declare_command(command_name)
        desc t("cli.commands.#{command_name}.description")
        command command_name do |c|
          c.action &Command.new(command_name).action
        end
      end
    end

    private

    LOG_COLUMN_LENGTH = 20

    def columns(description, content)
      "#{description}: ".ljust(LOG_COLUMN_LENGTH) + content
    end

    def header(text)
      debug "\n#{text}"
    end
  end
end
