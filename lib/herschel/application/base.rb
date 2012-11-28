require 'herschel'

module Herschel
  module Application
    class Base
      include Methadone::CLILogging
      include Herschel::I18n
    end
  end
end
