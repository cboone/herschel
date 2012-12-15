require 'herschel'

module Herschel
  class FileSystem < Application::Base
    def initialize(options = {})
      @options = options
    end

    def clean_up
      working_directory.clean_up if @working_directory
    end

    def template?(path)
      !!Tilt[path]
    rescue LoadError => exception
      handler = exception.to_s.sub(/\A.*-- /, '')
      debug "template handler (#{handler}) not found for: #{path}"
      false
    end

    def template_directory
      @template_directory ||= Directory.new options[:template_directory], file_system: self
    end

    def template_names
      @template_names ||= {
        directory: options[:directory_template],
        image: options[:image_template],
        root: options[:root_template]
      }
    end

    def templates
      @templates ||= {
        directory:  template_directory.template(template_names[:directory]),
        image:  template_directory.template(template_names[:image]),
        root: template_directory.template(template_names[:root])
      }
    end

    def working_directory
      @working_directory ||= WorkingDirectory.new file_system: self
    end

    private

    attr_reader :options

    #attr_reader :image_types
    #
    #def initialize(options = {})
    #  @image_types = options[:image_types] || []
    #end
    #
    #def image?(path)
    #  path = Pathname.new path
    #  @image_types.include? path.extname
    #end

    #def new_file_or_dir(path)
    #  path = Pathname.new path
    #  return if path.basename.to_s[0] == '.'
    #
    #  if path.directory?
    #    Directory.new path, file_system: self
    #  elsif path.file?
    #    if image? path
    #      File.new path, file_system: self
    #    elsif template? path
    #      Template.new path, file_system: self
    #    end
    #  end
    #end
  end
end
