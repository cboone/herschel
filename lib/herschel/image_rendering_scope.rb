module Herschel
  class ImageRenderingScope < RenderingScope
    def path(version)
      object.version(version).absolute_url_path
    end
  end
end
