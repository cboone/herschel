require 'herschel'

module Herschel
  module Application
    module Base
      include Methadone::CLILogging
      include Herschel::I18n
    end
  end
end
