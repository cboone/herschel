module Herschel
  class DirectoryRenderingScope < RenderingScope
    def directories
      @directories ||= object.directories.map &:rendering_scope
    end

    alias_method :galleries, :directories

    #def image_path
    #object.images.first.path
    #end
  end
end
