require 'herschel'

module Herschel
  class Dir
    include Enumerable

    def initialize(path)
      @path = Pathname.new ::File.expand_path path
    end

    def each(&block)
      @path.each_child do |child|
        file_or_dir = FileSystem.new_file_or_dir child
        block.call file_or_dir if file_or_dir
      end
    end

    def path
      @path.to_s
    end

    def graph
      [path, map(&:graph)]
    end
  end
end
