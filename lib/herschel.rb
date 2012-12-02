if ENV['DEVELOPMENT']
  require 'pry'
  require 'pry-nav'
end

require 'gli'
require 'methadone/cli_logger'
require 'methadone/cli_logging'
require 'pathname'

require 'herschel/version.rb'

require 'herschel/i18n'

require 'herschel/file_system'
require 'herschel/file'
require 'herschel/dir'

require 'herschel/application/base'
require 'herschel/commands/base'
require 'herschel/commands/analyze'
require 'herschel/cli'
