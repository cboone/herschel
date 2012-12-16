module Herschel
  class Image < File
    def rendering_scope
      @rendering_scope ||= ImageRenderingScope.new self
    end
  end
end
