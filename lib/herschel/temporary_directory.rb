require 'herschel'

module Herschel
  class WorkingDirectory < Directory
    def initialize(options = {})
      super Dir.mktmpdir %w(herschel- -working), options
    end

    def clean_up
      FileUtils.remove_entry_secure path
      debug "removed temporary directory: #{path}"
    end
  end
end
