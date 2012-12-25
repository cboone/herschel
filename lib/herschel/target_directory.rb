module Herschel
  class TargetDirectory < Directory
    alias_method :path, :source_path
    alias_method :target_path, :source_path
  end
end
