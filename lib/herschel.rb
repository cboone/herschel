if ENV['DEVELOPMENT']
  require 'pry'
  require 'pry-nav'
  require 'pry-stack_explorer'
end

require 'gli'
require 'methadone/cli_logger'
require 'methadone/cli_logging'

require 'pathname'
require 'tmpdir'

require 'tilt'
require 'slim'

require 'herschel/version.rb'

require 'herschel/i18n'
require 'herschel/application/base'

require 'herschel/file_system'
require 'herschel/file'
require 'herschel/template'

require 'herschel/directory'
require 'herschel/temporary_directory'

require 'herschel/argv'
require 'herschel/command'

require 'herschel/cli/accepts'
require 'herschel/cli/errors'
require 'herschel/cli/flags'
require 'herschel/cli/logging'
require 'herschel/cli/post_process'
require 'herschel/cli/pre_process'
require 'herschel/cli/switches'
require 'herschel/cli/version'
require 'herschel/cli'
