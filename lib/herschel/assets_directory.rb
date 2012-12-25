module Herschel
  class AssetsDirectory < Directory
    def finalize(link = false)
      directories.each do |subdirectory|
        if link
          subdirectory.target_path.make_symlink subdirectory.source_path
        else
          FileUtils.cp_r subdirectory.source_path, subdirectory.target_path
        end
      end
    end

    def root
      self
    end
  end
end
