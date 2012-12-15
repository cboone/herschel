module Herschel
  class CLI
    module Switches
      def declare_global_switches
        switch [:n, :'dry-run'],
               negatable: false,
               desc: t('cli.switches.dry-run')
        switch [:q, :quiet],
               negatable: false,
               desc: t('cli.switches.quiet')
        switch [:v, :verbose],
               negatable: false,
               desc: t('cli.switches.verbose')
      end
    end
  end
end
