require 'herschel'

module Herschel
  class Directory < Application::Base
    attr_accessor :file_system
    attr_reader :options, :parent, :path, :root

    def initialize(path, options = {})
      @options = options.dup
      @parent = @options[:parent]
      @path = Pathname.new ::File.expand_path path
      @file_system = @options[:file_system]
      @root = @options[:root] || self
    end

    def directories
      @directories ||= file_system.subdirectories_within self
    end

    def images
      @images ||= file_system.images_within self
    end

    def template(file_name)
      templates[templates.keys.find do |pathname|
        pathname.to_s == file_name
      end]
    end

    def templates
      @templates ||= file_system.templates_within self
    end

    def to_s
      path.to_s
    end
  end
end
