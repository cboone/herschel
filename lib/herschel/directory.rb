require 'herschel'

module Herschel
  class Directory < Application::Base
    #include Enumerable

    attr_accessor :file_system
    attr_reader :parent, :path, :root

    def initialize(path, options = {})
      @options = options
      @parent = options[:parent]
      @path = Pathname.new ::File.expand_path path
      @file_system = options[:file_system]
      @root = options[:root] || self
    end

    def to_s
      path.to_s
    end

    def template(file_name)
      templates[templates.keys.find do |pathname|
        pathname.to_s == file_name
      end]
    end

    def templates
      @templates ||= find_templates
    end

    #def each(&block)
    #  @path.each_child do |child|
    #    file_or_dir = file_system.new_file_or_dir child
    #    block.call file_or_dir if file_or_dir
    #  end
    #end
    #
    #def graph
    #  [path, map(&:graph)]
    #end

    private

    attr_reader :options

    def find_templates
      patterns = Tilt.mappings.keys.map do |extension|
        "#{path}/**/*.#{extension}"
      end

      files = Dir.glob(patterns).map do |path|
        if file_system.template? path
          file = Template.new(path, root: root)
          [file.relative_path, file]
        end
      end.compact

      Hash[files]
    end
  end
end
