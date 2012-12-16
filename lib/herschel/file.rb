require 'herschel'

module Herschel
  class File
    attr_reader :file_system, :path, :root

    def initialize(path, options = {})
      @options = options.dup
      @path = Pathname.new ::File.expand_path path
      @file_system = @options[:file_system]
      @root = @options[:root]
    end

    def relative_path
      path.relative_path_from root.path
    end

    def to_s
      path.to_s
    end

    private

    attr_reader :options
  end
end
