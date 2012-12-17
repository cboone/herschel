module Herschel
  class WorkingFile < File
    attr_reader :content, :file_name, :parent_path, :temp_file

    def initialize(file_name, parent_path, options = {})
      @file_name = file_name
      @parent_path = parent_path
      @relative_path = @parent_path + @file_name
      @temp_file = Tempfile.new @file_name
      super temp_file.path, options
    end

    def clean_up
      temp_file.close
      temp_file.unlink
    end

    def content=(stuff)
      @content = stuff
      temp_file.write @content
      temp_file.rewind
    end

    def finalize
      file_system.finalize self
    end
  end
end
