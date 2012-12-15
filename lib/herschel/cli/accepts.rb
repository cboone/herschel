module Herschel
  class CLI
    module Accepts
      def declare_acceptable_classes
        accept Array do |string|
          string.split ','
        end

        accept Pathname do |path|
          Pathname.new path
        end
      end
    end
  end
end
