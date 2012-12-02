require 'herschel'

module Herschel
  class Template < File
    attr_reader :template

    def initialize(path, options = {})
      super
      @template = Tilt.new self.path
    end
  end
end
