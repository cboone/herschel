require 'herschel'

module Herschel
  class FileSystem
    attr_reader :allowed_file_extensions

    def initialize(options = {})
      @allowed_file_extensions = options[:allowed] || []
    end

    def allowed?(path)
      path = Pathname.new path
      @allowed_file_extensions.include? path.extname
    end

    def new_file_or_dir(path)
      path = Pathname.new path
      return if path.basename.to_s[0] == '.'

      if path.directory?
        Dir.new path, file_system: self
      elsif path.file?
        return unless allowed_file_extensions.include? path.extname
        File.new path, file_system: self
      end
    end
  end
end
