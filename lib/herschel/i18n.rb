require 'i18n'

module Herschel
  module I18n
    def t(key, options = {})
      ::I18n.t key, options.merge(scope: 'herschel')
    end
  end
end
