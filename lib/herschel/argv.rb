require 'herschel'

module Herschel
  module Argv
    def self.preprocess(original_argv)
      argv = original_argv.dup

      if source_index = (argv.index('-S') || argv.index('--source'))
        source_path = ::File.expand_path argv[source_index + 1]
        FileUtils.cd source_path
        argv[source_index + 1] = source_path
      end

      if config_index = (argv.index('-c') || argv.index('--configuration'))
        config_path = ::File.expand_path argv[config_index + 1]
      else
        config_path = ::File.expand_path './config.yml'
        argv.unshift '-c', config_path
      end

      return argv, config_path
    end

    def simplify_options!(options = {})
      allowed_keys = [flags, switches].map(&:keys).flatten
      options.select! { |key| allowed_keys.include? key }
    end

    def process_accepts!(options)
      options.each do |key, value|
        if value && (option_config = flags[key])
          if (type = option_config.type) && !(value.is_a? type) && (converter = accepts[type])
            options[key] = converter.call value
          end
        end
      end
    end
  end
end
