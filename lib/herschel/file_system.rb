require 'herschel'

module Herschel
  class FileSystem < Application::Base
    attr_reader :options

    def initialize(options = {})
      @options = options.dup
    end

    def assets_directory
      @assets_directory ||= Directory.new options[:assets_directory], file_system: self, root: options[:assets_directory].basename
    end

    def clean_up
      source_directory.children.each do |child|
        child.clean_up
      end
      source_directory.clean_up
    end

    def directory?(pathname)
      pathname.directory? && visible?(pathname)
    end

    def excluded_directories
      @excluded_directories ||= [target_directory, template_directory]
    end

    def file?(pathname)
      pathname.file? && visible?(pathname)
    end

    def finalize(working_file)
      final_path = working_file.target_path
      FileUtils.mkpath final_path.dirname
      FileUtils.copy_file working_file.path, final_path
    end

    def finalize_assets
      FileUtils.cp_r assets_directory.path, target_directory.path
    end

    def image?(pathname)
      file?(pathname) && image_types.include?(pathname.extname)
    end

    def images_within(directory)
      directory.path.children.map do |child|
        child if image? child
      end.compact.map do |pathname|
        Image.new pathname, file_system: self, root: directory.root
      end
    end

    def image_types
      @image_types ||= (options[:image_types] || [])
    end

    def meta_filename
      @meta_filename ||= options[:meta_filename]
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
      @template_directory ||= TemplateDirectory.new options[:template_directory], file_system: self,
                                                    template_names: {
                                                      directory: options[:directory_template],
                                                      image: options[:image_template],
                                                      root: options[:root_template]
                                                    }
    end

    def template_for(object)
      case object
        when Directory
          if object.root?
            templates[:root]
          else
            templates[:directory]
          end
        when Image
          templates[:image]
      end
    end

    def templates
      @templates ||= {
        directory: template_directory.template_for(:directory),
        image: template_directory.template_for(:image),
        root: template_directory.template_for(:root)
      }
    end

    def visible?(pathname)
      pathname.basename.to_s[0] != '.'
    end
  end
end
