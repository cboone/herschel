module Herschel
  class DirectoryRenderingScope < RenderingScope
    def directories
      @directories ||= object.directories.map &:rendering_scope
    end

    alias_method :galleries, :directories

    def images
      @images ||= object.images.map &:rendering_scope
    end

    def image_path
      images.first.path
    end
  end
end
