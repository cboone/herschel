require 'herschel'

module Herschel
  class File
    include Application::Base

    attr_reader :file_system, :root, :source_path

    def initialize(source_path, options = {})
      @options = options.dup
      @file_system = @options[:file_system]
      @root = @options[:root]
      @source_path = Pathname.new ::File.expand_path source_path
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
      @relative_path ||= source_path.relative_path_from root.source_path
    end

    def target_path
      @target_path ||= file_system.target_directory.path + relative_path
    end

    def to_s
      source_path.to_s
    end

    private

    attr_reader :options
  end
end
