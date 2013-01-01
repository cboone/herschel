module Herschel
  class CLI
    module Switches
      def declare_global_switches
        switch :'link-assets',
               desc: t('cli.switches.link-assets')
        switch [:n, :'dry-run'],
               desc: t('cli.switches.dry-run')
        switch [:q, :quiet],
               desc: t('cli.switches.quiet')
        switch :'skip-assets',
               desc: t('cli.switches.skip-assets')
        switch :'skip-images',
               desc: t('cli.switches.skip-images')
        switch :'use-local-file-paths',
               desc: t('cli.switches.use-local-file-paths')
        switch [:v, :verbose],
               desc: t('cli.switches.verbose')
      end
    end
  end
end
