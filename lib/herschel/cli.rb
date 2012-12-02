require 'herschel'

module Herschel
  class CLI
    extend GLI::App
    include Methadone::CLILogging
    extend I18n
    include I18n
    extend Support

    switch [:v, :verbose],
           negatable: false,
           desc: t('cli.switches.verbose')
    switch [:q, :quiet],
           negatable: false,
           desc: t('cli.switches.quiet')

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

    desc t('cli.commands.analyze.description')
    command :analyze do |c|
      c.action &Commands::Analyze.action
    end

    pre do |global_options, command, options, arguments|
      global_options.tap do |go|
        simplify_options go, flags, switches
        set_log_level go[:v], go[:q]
        process_accepts go, accepts, flags

        go[:file_system] = FileSystem.new image_types: go[:'image-types']
        go[:d].file_system = go[:file_system]
      end
    end

    accept Array do |string|
      string.split(',')
    end

    accept Directory do |path|
      Directory.new path
    end

    accept Pathname do |path|
      Pathname.new ::File.expand_path path
    end

    program_desc t('cli.description')

    @version = Herschel::VERSION
    switch :version,
           negatable: false,
           desc: t('cli.switches.version')
  end
end
