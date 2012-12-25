module Herschel
  class ImageRenderingScope < RenderingScope
    def path(version)
      @path ||= object.version(version).absolute_url_path
    end
  end
end
