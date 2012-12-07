module Herschel
  class CLI
    module Accepts
      def declare_acceptable_classes
        accept Array do |string|
          string.split(',')
        end

        accept Herschel::Directory do |path|
          Herschel::Directory.new path
        end

        accept Pathname do |path|
          Pathname.new ::File.expand_path path
        end
      end
    end
  end
end
