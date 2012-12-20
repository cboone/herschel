require 'herschel'

module Herschel
  class File
    attr_reader :file_system, :path, :root

    def initialize(path, options = {})
      @options = options.dup
      @file_system = @options[:file_system]
      @path = Pathname.new ::File.expand_path path
      @root = @options[:root]
    end

    def absolute_url_path
      @absolute_url_path ||= if file_system.use_local_file_paths?
                               target_path.to_s
                             else
                               '/' + relative_path.to_s
                             end
    end

    def inspect
      "#<#{self.class.name}:#{to_s}>"
    end

    def relative_path
      @relative_path ||= path.relative_path_from root.path
    end

    def target_path
      @target_path ||= file_system.target_directory.path + relative_path
    end

    def to_s
      path.to_s
    end

    private

    attr_reader :options
  end
end
