require 'herschel'

module Herschel
  class File
    def initialize(path)
      @path = Pathname.new ::File.expand_path path
    end

    def path
      @path.to_s
    end
    alias_method :graph, :path
  end
end
