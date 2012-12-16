require 'herschel'

module Herschel
  class WorkingDirectory < Directory
    def initialize(options = {})
      super Dir.mktmpdir(%w(herschel- -working)), options
    end

    def clean_up
      FileUtils.remove_entry_secure path
      debug "removed working directory: #{path}"
    end

    def create_file(file_name, parent_path, content)
      WorkingFile.new file_name, parent_path, content, file_system: file_system, parent: self, root: root
    end
  end
end
