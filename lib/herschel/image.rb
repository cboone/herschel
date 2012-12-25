module Herschel
  class Image < File
    def dimensions
      @dimensions ||= "#{image[:width]}x#{image[:height]}"
    end

    def format
      @format ||= image[:format]
    end

    def image
      @image ||= MiniMagick::Image.open source_path
    end

    def rendering_scope
      @rendering_scope ||= ImageRenderingScope.new self
    end

    def version(name)
      versions[name]
    end

    def versions
      @versions ||= Hash[
        file_system.image_versions.map do |name, dimensions|
          [name, ImageVersion.new(self, name, dimensions, file_system: file_system)]
        end
      ]
    end
  end
end
