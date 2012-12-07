module Herschel
  class CLI
    module Version
      def declare_version
        @version = Herschel::VERSION
        switch :version,
               negatable: false,
               desc: t('cli.switches.version')
      end
    end
  end
end
