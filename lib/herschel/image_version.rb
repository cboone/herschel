module Herschel
  class ImageVersion
    attr_reader :dimensions, :image, :name

    def initialize(image, name, dimensions, options = {})
      @dimensions = dimensions
      @image = image
      @name = name
    end

    def extension
      image.target_path.extname
    end

    def finalize
      image.image.resize dimensions
      image.image.write target_path
    end

    def target_path
      return @target_path if @target_path

      base_target_path = image.target_path.to_s
      @target_path = Pathname.new base_target_path.gsub(extension, "_#{name}#{extension}")
    end
  end
end
