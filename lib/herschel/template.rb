require 'herschel'

module Herschel
  class Template < File
    attr_reader :template

    def initialize(path, options = {})
      super
      @template = Tilt.new self.to_s
    end
  end
end
