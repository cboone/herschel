module Herschel
  class CLI
    module Switches
      def setup_switches
        switch [:v, :verbose],
               negatable: false,
               desc: t('cli.switches.verbose')
        switch [:q, :quiet],
               negatable: false,
               desc: t('cli.switches.quiet')
      end
    end
  end
end
