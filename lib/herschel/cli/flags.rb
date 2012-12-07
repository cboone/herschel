module Herschel
  class CLI
    module Flags
      def declare_global_flags
        flag [:c, :configuration],
             arg_name: 'PATH',
             default_value: './herschel.yml',
             desc: t('cli.flags.configuration'),
             negatable: false,
             type: Pathname
        flag [:d, :directory],
             arg_name: 'PATH',
             default_value: './',
             desc: t('cli.flags.directory'),
             type: Directory
        flag [:'image-types'],
             arg_name: 'EXT1[,EXT2..]',
             default_value: t('cli.flags.image-types.default'),
             desc: t('cli.flags.image-types.description'),
             negatable: false,
             type: Array
        flag [:'output-directory'],
             arg_name: 'PATH',
             default_value: './site',
             desc: t('cli.flags.output-directory'),
             negatable: false,
             type: Directory
        flag :'root-template',
             arg_name: 'FILENAME',
             default_value: 'root.html.slim',
             desc: t('cli.flags.root-template'),
             negatable: false
        flag :'template-directory',
             arg_name: 'PATH',
             default_value: './templates',
             desc: t('cli.flags.template-directory'),
             negatable: false,
             type: Pathname
        flag :'working-directory',
             arg_name: 'PATH',
             desc: t('cli.flags.working-directory'),
             negatable: false,
             type: Pathname
      end
    end
  end
end
