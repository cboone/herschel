require 'herschel'

module Herschel
  class File
    attr_reader :file_system

    def initialize(path, options = {})
      @path = Pathname.new ::File.expand_path path
      @file_system = options[:file_system] || FileSystem.new
    end

    def path
      @path.to_s
    end
    alias_method :graph, :path
    alias_method :to_s, :path
  end
end
