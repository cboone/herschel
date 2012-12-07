module Herschel
  class CLI
    module Preprocess
      def preprocess
        pre do |global_options, command, options, arguments|
          global_options.tap do |go|
            simplify_options! go
            set_log_level go[:v], go[:q]
            process_accepts! go

            go[:file_system] = FileSystem.new image_types: go[:'image-types']
            go[:d].file_system = go[:file_system]
          end
        end
      end
    end
  end
end
