require 'herschel'

module Herschel
  class Directory < Application::Base
    attr_accessor :file_system
    attr_reader :options, :path, :root

    def initialize(path, options = {})
      @options = options.dup
      @path = Pathname.new ::File.expand_path path
      @file_system = @options[:file_system]
      @root = @options[:root] || self
    end

    def absolute_url_path
      return @absolute_url_path if @absolute_url_path

      url_path = relative_path.to_s
      if /\A \.\/ /x === url_path
        @absolute_url_path = url_path[1..-1]
      elsif url_path == '.'
        @absolute_url_path = '/'
      else
        @absolute_url_path = '/' + url_path
      end
    end

    def compiled
      @compiled ||= template.compile rendering_scope
    end

    def directories
      @directories ||= file_system.subdirectories_within self
    end

    def images
      @images ||= file_system.images_within self
    end

    def meta
      return @meta if @meta

      meta_file_name = path + file_system.meta_filename
      if meta_file_name.exist?
        @meta = YAML.load_file meta_file_name
      else
        @meta = {}
      end
    end

    def name
      @name ||= meta['name']
    end

    def relative_path
      @relative_path ||= path.relative_path_from root.path
    end

    def rendering_scope
      @rendering_scope ||= DirectoryRenderingScope.new self
    end

    def root?
      root == self
    end

    def target_path
      @target_path ||= file_system.target_directory.path + relative_path
    end

    def template(file_name = nil)
      if file_name
        templates[templates.keys.find do |pathname|
          pathname.to_s == file_name
        end]
      else
        @template ||= file_system.template_for self
      end
    end

    def templates
      @templates ||= file_system.templates_within self
    end

    def to_s
      path.to_s
    end
  end
end
