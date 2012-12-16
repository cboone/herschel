module Herschel
  class RenderingScope
    attr_reader :object

    def initialize(object)
      @object = object
    end

    def name
      @name ||= object.name
    end

    def path
      @path ||= object.absolute_url_path
    end

    def root
      @root ||= object.root.rendering_scope
    end
  end
end
