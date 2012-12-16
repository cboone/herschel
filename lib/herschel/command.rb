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
      debug 'FILE SYSTEM'
      info columns 'assets', file_system.assets_directory.to_s
      info columns 'source', file_system.source_directory.to_s
      info columns 'target', file_system.target_directory.to_s
      info columns 'templates', file_system.template_directory.to_s
      info columns 'working', file_system.working_directory.to_s if file_system.working_directory?
      debug ''
    end

    def analyze_images
      debug 'IMAGES'
      info columns 'image types', file_system.image_types.join(', ')
      debug ''
    end

    def analyze_source
      debug 'SOURCE'
      file_system.source_directory.tap do |source|
        info source.to_s
        source.directories.each do |directory|
          info directory.to_s
          directory.images.each do |image|
            info image.to_s
          end
        end
      end
      debug ''
    end

    def analyze_templates
      debug 'TEMPLATES'
      info columns 'templates', file_system.template_directory.to_s
      file_system.templates.each do |name, file|
        info columns name, file.to_s
      end
      debug ''
    end

    def compile
      compile_root
      compile_directories
    end

    def compile_root
      debug 'COMPILE - ROOT'

      compiled = file_system.source_directory.compile
      file_system.source_directory.finalize

      debug columns 'from', file_system.source_directory.to_s
      debug columns 'through', compiled.to_s
      debug columns 'to', file_system.target_directory.to_s
      debug file_system.source_directory.compiled
      debug ''
    end

    def compile_directories
      debug 'COMPILE - DIRECTORIES'

      file_system.source_directory.directories.each do |directory|
        compiled = file_system.compile directory

        debug columns 'from', directory.to_s
        debug columns 'through', compiled.path
        debug columns 'to', directory.target_path.to_s
        debug directory.compiled
      end
      debug ''
    end

    def debug_options
      debug 'GLOBAL OPTIONS'
      global_options.each do |option, value|
        debug columns option, value.inspect
      end
      debug ''
    end

    def images
      debug 'IMAGES'
      debug ''
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
  end
end
