require 'spec_helper'

describe Herschel::FileSystem do
  describe '#assets_directory' do
    pending
  end

  describe '#clean_up' do
    pending
  end

  describe '#directory?' do
    pending
  end

  describe '#excluded_directories' do
    pending
  end

  describe '#file' do
    pending
  end

  describe '#finalize' do
    pending
  end

  describe '#image?' do
    pending
  end

  describe '#image_types' do
    subject { file_system.image_types }

    context 'when extensions are specified' do
      let(:file_system) { Herschel::FileSystem.new image_types: ['.jpg'] }
      it { should == ['.jpg'] }
    end

    context 'when extensions are not specified' do
      let(:file_system) { Herschel::FileSystem.new }
      it { should == [] }
    end
  end

  describe '#images_within' do
    pending
  end

  describe '#meta_filename' do
    pending
  end

  describe '#source_directory' do
    let(:file_system) {
      Herschel::FileSystem.new source_directory: '/tmp/source'
    }

    subject { file_system.source_directory }

    it { should be_a Herschel::Directory }
    its(:to_s) { should == '/tmp/source' }
    its(:file_system) { should == file_system }
  end

  describe '#subdirectories_within' do
    pending
  end

  describe '#target_directory' do
    let(:file_system) {
      Herschel::FileSystem.new target_directory: '/tmp/target'
    }

    subject { file_system.target_directory }

    it { should be_a Herschel::Directory }
    its(:to_s) { should == '/tmp/target' }
    its(:file_system) { should == file_system }
  end

  describe '#template?' do
    pending
    #  let(:file_system) { Herschel::FileSystem.new }
    #  let(:path) { file.path }
    #
    #  after do
    #    file.close
    #    file.unlink
    #  end
    #
    #  subject { file_system.template? path }
    #
    #  context 'when the file extension is a registered and loaded template type' do
    #    let(:file) { Tempfile.new ['herschel', '.html.slim'] }
    #    it { should == true }
    #  end
    #
    #  context 'when the file extension is a registered and unloaded template type' do
    #    let(:file) { Tempfile.new ['herschel', '.css.less'] }
    #    it { should == false }
    #  end
    #
    #  context 'when the file extension is not a template type' do
    #    let(:file) { Tempfile.new ['herschel', '.txt'] }
    #    it { should == false }
    #  end
  end

  describe '#template_directory' do
    let(:file_system) {
      Herschel::FileSystem.new template_directory: '/tmp/templates'
    }

    subject { file_system.template_directory }

    it { should be_a Herschel::Directory }
    its(:to_s) { should == '/tmp/templates' }
    its(:file_system) { should == file_system }
  end

  describe '#template_for' do
    pending
  end

  describe '#template_names' do
    pending
  end

  describe '#templates' do
    let(:file_system) {
      path = File.dirname(__FILE__) + '/fixtures/templates'
      Herschel::FileSystem.new(
        template_directory: path,
        directory_template: 'directory.html.slim',
        image_template: 'image.html.slim',
        root_template: 'root.html.slim'
      )
    }
    let(:templates) { file_system.templates }

    specify { templates.keys.should =~ [:directory, :image, :root] }

    describe 'directory' do
      subject { templates[:directory] }

      it { should be_a Herschel::Template }
      its('relative_path.to_s') { should == 'directory.html.slim' }
    end

    describe 'image' do
      subject { templates[:image] }

      it { should be_a Herschel::Template }
      its('relative_path.to_s') { should == 'image.html.slim' }
    end

    describe 'root' do
      subject { templates[:root] }

      it { should be_a Herschel::Template }
      its('relative_path.to_s') { should == 'root.html.slim' }
    end
  end

  describe '#templates_within' do
    pending
  end

  describe '#visible?' do
    pending
  end
end
