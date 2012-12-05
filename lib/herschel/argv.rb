require 'herschel'

module Herschel
  module Argv
    def self.preprocess(original_argv)
      argv = original_argv.dup

      if d_index = (argv.index('-d') || argv.index('--directory'))
        FileUtils.cd argv[d_index + 1]
        argv[d_index + 1] = './'
      end

      if c_index = (argv.index('-c') || argv.index('--configuration'))
        config_path = ::File.expand_path argv[c_index + 1]
      else
        config_path = ::File.expand_path './herschel.yml'
        argv += ['-c', config_path]
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
