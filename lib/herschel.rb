if ENV['DEVELOPMENT']
  require 'pry'
  require 'pry-nav'
end

require 'gli'
require 'methadone/cli_logger'
require 'methadone/cli_logging'

require 'pathname'

require 'tilt'
require 'slim'

require 'herschel/version.rb'

require 'herschel/i18n'
require 'herschel/application/base'

require 'herschel/file_system'
require 'herschel/file'
require 'herschel/template'
require 'herschel/directory'

require 'herschel/commands/base'
require 'herschel/commands/analyze'
require 'herschel/cli/support'
require 'herschel/cli'
