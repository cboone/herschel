module Herschel
  class TemplateDirectory < Directory
    attr_reader :template_names

    def initialize(path, options = {})
      super
      @template_names = options[:template_names]
    end

    def template_for(name)
      templates[templates.keys.find do |pathname|
        pathname == template_names[name]
      end]
    end

    def templates
      return @templates if @templates

      patterns = Tilt.mappings.keys.map do |extension|
        "#{source_path}/**/*.#{extension}"
      end

      files = Dir.glob(patterns).map do |path|
        if file_system.template? path
          file = Template.new path, root: root
          [file.relative_path, file]
        end
      end.compact

      @templates = Hash[files]
    end
  end
end
