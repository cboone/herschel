require 'i18n'

locales = File.expand_path('../../../locales', __FILE__)
I18n.load_path += Dir[locales + '/*.yml']
I18n.backend.load_translations

module Herschel
  module I18n
    def t(key, options = {})
      ::I18n.t key, options.merge(scope: 'herschel')
    end
  end
end
