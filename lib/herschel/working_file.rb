module Herschel
  class WorkingFile < File
    attr_reader :file_name, :parent_path, :temp_file

    def initialize(file_name, parent_path, content, options = {})
      @file_name = file_name
      @parent_path = parent_path

      file_name_parts = file_name.partition('.')
      @temp_file = Tempfile.new [file_name_parts.shift, file_name_parts.join], options[:parent].path

      super temp_file.path, options

      @temp_file.write content
      @temp_file.rewind
    end

    def finalize
      file_system.finalize self, file_name, parent_path
    end
  end
end
