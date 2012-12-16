require 'herschel'

module Herschel
  class FileSystem < Application::Base
    attr_reader :options

    def initialize(options = {})
      @options = options.dup
    end

    def clean_up
      working_directory.clean_up if @working_directory
    end

    def directory?(pathname)
      pathname.directory? && visible?(pathname)
    end

    def excluded_directories
      [target_directory, template_directory]
    end

    def file?(pathname)
      pathname.file? && visible?(pathname)
    end

    def image?(pathname)
      file?(pathname) && image_types.include?(pathname.extname)
    end

    def images_within(directory)
      directory.path.children.map do |child|
        child if image? child
      end.compact.map do |pathname|
        Herschel::Image.new pathname, file_system: self, root: directory.root
      end
    end

    def image_types
      @image_types ||= (options[:image_types] || [])
    end

    def source_directory
      @source_directory ||= Directory.new options[:source_directory], file_system: self
    end

    def subdirectories_within(directory)
      directories = directory.path.children.map do |child|
        child if directory? child
      end.compact - excluded_directories.map(&:path)

      directories.map do |path|
        Directory.new path, file_system: self, root: directory.root
      end
    end

    def target_directory
      @target_directory ||= Directory.new options[:target_directory], file_system: self
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
        directory: template_directory.template(template_names[:directory]),
        image: template_directory.template(template_names[:image]),
        root: template_directory.template(template_names[:root])
      }
    end

    def templates_within(directory)
      patterns = Tilt.mappings.keys.map do |extension|
        "#{directory.to_s}/**/*.#{extension}"
      end

      files = Dir.glob(patterns).map do |path|
        if template? path
          file = Template.new(path, root: directory.root)
          [file.relative_path, file]
        end
      end.compact

      Hash[files]
    end

    def visible?(pathname)
      pathname.basename.to_s[0] != '.'
    end

    def working_directory
      @working_directory ||= WorkingDirectory.new file_system: self
    end

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
