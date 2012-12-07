if ENV['DEVELOPMENT']
  require 'pry'
  require 'pry-coolline'
  require 'pry-exception_explorer'
  require 'pry-nav'
  require 'pry-stack_explorer'
end

require 'gli'
require 'methadone/cli_logger'
require 'methadone/cli_logging'

require 'pathname'

require 'tilt'
require 'slim'

require 'herschel/version.rb'

require 'herschel/i18n'
require 'herschel/argv'
require 'herschel/application/base'

require 'herschel/file_system'
require 'herschel/file'
require 'herschel/template'
require 'herschel/directory'

require 'herschel/commands/base'
require 'herschel/commands/analyze'
require 'herschel/logging'

require 'herschel/cli/accepts'
require 'herschel/cli/errors'
require 'herschel/cli/flags'
require 'herschel/cli/preprocess'
require 'herschel/cli/switches'
require 'herschel/cli/version'
require 'herschel/cli'
