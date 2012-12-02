require 'herschel'

module Herschel
  class Dir
    include Enumerable

    attr_accessor :file_system

    def initialize(path, options = {})
      @path = Pathname.new ::File.expand_path path
      @file_system = options[:file_system] || FileSystem.new
    end

    def path
      @path.to_s
    end
    alias_method :to_s, :path

    def each(&block)
      @path.each_child do |child|
        file_or_dir = file_system.new_file_or_dir child
        block.call file_or_dir if file_or_dir
      end
    end

    def graph
      [path, map(&:graph)]
    end
  end
end
