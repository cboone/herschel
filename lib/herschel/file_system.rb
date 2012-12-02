require 'herschel'

module Herschel
  class FileSystem < Application::Base
    attr_reader :image_types

    def initialize(options = {})
      @image_types = options[:image_types] || []
    end

    def image?(path)
      path = Pathname.new path
      @image_types.include? path.extname
    end

    def template?(path)
      !!Tilt[path]
    rescue LoadError => exception
      handler = exception.to_s.sub(/\A.*-- /, '')
      debug "template handler (#{handler}) not found for: #{path}"
      false
    end

    def new_file_or_dir(path)
      path = Pathname.new path
      return if path.basename.to_s[0] == '.'

      if path.directory?
        Directory.new path, file_system: self
      elsif path.file?
        if image? path
          File.new path, file_system: self
        elsif template? path
          Template.new path, file_system: self
        end
      end
    end
  end
end
