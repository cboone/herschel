require 'herschel'

module Herschel
  class Directory
    include Application::Base

    attr_reader :file_system, :root, :source_path

    def initialize(source_path, options = {})
      @options = options.dup
      @file_system = @options[:file_system]
      @root = @options[:root] || self
      @source_path = Pathname.new ::File.expand_path source_path
    end

    def absolute_url_path
      @absolute_url_path = if file_system.use_local_file_paths?
                             (target_path + target_file_name).to_s
                           else
                             url_path = relative_path.to_s
                             if url_path[0..1] == './'
                               url_path[1..-1]
                             elsif url_path == '.'
                               '/'
                             else
                               '/' + url_path
                             end
                           end
    end

    def children
      directories + images
    end

    def clean_up
      compiled_file.clean_up if compiled?
    end

    def compile
      compiled_file.content = render
    end

    def compiled?
      !@compiled_file.nil?
    end

    def compiled_file
      @compiled_file ||= WorkingFile.new target_file_name, relative_path, file_system: file_system
    end

    def directories
      @directories ||= file_system.subdirectories_within self
    end

    def featured_image
      if meta['featured']
        images.find do |image|
          image.name.to_s == meta['featured']
        end
      else
        images.first
      end
    end

    def finalize
      @compiled_file.finalize
    end

    def images
      @images ||= file_system.images_within self
    end

    def inspect
      "#<#{self.class.name}:#{to_s}>"
    end

    def meta
      return @meta if @meta

      meta_file_name = source_path + file_system.meta_filename
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
      @relative_path ||= source_path.relative_path_from root.source_path
    end

    def render
      @rendered ||= template.render rendering_scope
    end

    alias_method :rendered, :render

    def rendering_scope
      @rendering_scope ||= DirectoryRenderingScope.new self
    end

    def root?
      root == self
    end

    def target_file_name
      'index.html'
    end

    def target_path
      @target_path ||= file_system.target_directory.path + relative_path
    end

    def template
      @template ||= file_system.template_for self
    end

    def to_s
      source_path.to_s
    end

    private

    attr_reader :options
  end
end
