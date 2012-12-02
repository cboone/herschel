require 'herschel'

module Herschel
  class FileSystem
    DEFAULT_ALLOWED_FILE_EXTENSIONS = %w( .jpg .png )

    def self.allowed_file_extensions
      DEFAULT_ALLOWED_FILE_EXTENSIONS
    end

    def self.new_file_or_dir(path)
      path = Pathname.new path
      return if path.basename.to_s[0] == '.'

      if path.directory?
        Dir.new path
      elsif path.file?
        return unless allowed_file_extensions.include? path.extname
        File.new path
      end
    end
  end
end
