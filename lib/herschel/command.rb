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
        @file_system = FileSystem.new assets_directory: go[:A],
                                      source_directory: go[:S],
                                      target_directory: go[:O],
                                      template_directory: go[:T],

                                      directory_template: go[:'directory-template'],
                                      image_template: go[:'image-template'],
                                      root_template: go[:'root-template'],

                                      meta_filename: go[:m],
                                      image_types: go[:'image-types']

      debug_options unless @commands.include? :debug_options
      @commands.each do |command|
        send command
      end
    end

    def analyze
      analyze_file_system
      analyze_images
      analyze_source
      analyze_templates
    end

    def analyze_file_system
      header 'FILE SYSTEM'
      info columns 'assets', file_system.assets_directory.to_s
      info columns 'source', file_system.source_directory.to_s
      info columns 'target', file_system.target_directory.to_s
      info columns 'templates', file_system.template_directory.to_s
      info columns 'working', file_system.working_directory.to_s if file_system.working_directory?
    end

    def analyze_images
      header 'IMAGES'
      info columns 'image types', file_system.image_types.join(', ')
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

    def compile
      compile_root
      compile_directories
    end

    def compile_root
      header 'COMPILE - ROOT'
      debug columns 'from', file_system.source_directory.to_s
      debug columns 'to', file_system.target_directory.to_s
      debug file_system.source_directory.compiled
    end

    def compile_directories
      header 'COMPILE - DIRECTORIES'
      file_system.source_directory.directories.each do |directory|
        debug columns 'from', directory.to_s
        debug columns 'to', directory.target_path.to_s
        debug directory.compiled
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
