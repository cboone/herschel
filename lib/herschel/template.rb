require 'herschel'

module Herschel
  class Template < File
    def render(rendering_scope)
      template.render rendering_scope
    end

    def template
      @template ||= Tilt.new self.to_s
    end
  end
end
