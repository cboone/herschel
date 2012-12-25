module Herschel
  class RenderingScope
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

    private

    attr_reader :object
  end
end
