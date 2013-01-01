module Herschel
  class ImageVersion
    attr_reader :dimensions, :file_system, :name, :source_image

    def initialize(image, name, dimensions, options = {})
      @options = options.dup
      @dimensions = dimensions
      @file_system = @options[:file_system]
      @source_image = image
      @name = name
    end

    def absolute_url_path
      @absolute_url_path ||= if file_system.use_local_file_paths?
                               target_path.to_s
                             else
                               '/' + relative_path.to_s
                             end
    end

    def extension
      source_image.target_path.extname
    end

    def finalize
      image.resize dimensions
      image.write target_path
    end

    def image
      @image ||= MiniMagick::Image.open source_image.source_path
    end

    def rendering_scope
      @rendering_scope ||= ImageRenderingScope.new self
    end

    def target_path
      return @target_path if @target_path

      base_target_path = source_image.target_path.to_s
      @target_path = Pathname.new base_target_path.gsub(extension, "_#{name}#{extension}")
    end

    private

    attr_reader :options
  end
end
