module Herschel
  class CLI
    module Flags
      def declare_global_flags
        flag [:c, :configuration],
             arg_name: 'PATH',
             default_value: './config.yml',
             desc: t('cli.flags.configuration'),
             negatable: false,
             type: Pathname

        flag :'image-types',
             arg_name: 'EXT1[,EXT2..]',
             default_value: t('cli.flags.image-types.default'),
             desc: t('cli.flags.image-types.description'),
             negatable: false,
             type: Array

        flag [:O, :output],
             arg_name: 'PATH',
             default_value: 'site',
             desc: t('cli.flags.output'),
             negatable: false,
             type: Pathname
        flag [:S, :source],
             arg_name: 'PATH',
             default_value: Dir.pwd,
             desc: t('cli.flags.source'),
             type: Pathname
        flag [:T, :templates],
             arg_name: 'PATH',
             default_value: 'templates',
             desc: t('cli.flags.templates'),
             negatable: false,
             type: Pathname

        flag :'directory-template',
             arg_name: 'FILENAME',
             default_value: 'directory.html.slim',
             desc: t('cli.flags.directory-template'),
             negatable: false
        flag :'image-template',
             arg_name: 'FILENAME',
             default_value: 'image.html.slim',
             desc: t('cli.flags.image-template'),
             negatable: false
        flag :'root-template',
             arg_name: 'FILENAME',
             default_value: 'root.html.slim',
             desc: t('cli.flags.root-template'),
             negatable: false
      end
    end
  end
end
