require 'spec_helper'

describe Herschel::FileSystem do
  describe '#clean_up' do
    let(:file_system) { Herschel::FileSystem.new }
    let(:temp) { stub }

    before do
      file_system.instance_variable_set :@working_directory, temp
      temp.should_receive :clean_up
    end

    specify { file_system.clean_up }
  end

  describe '#template_directory' do
    let(:file_system) {
      Herschel::FileSystem.new template_directory: '/tmp/templates'
    }

    subject { file_system.template_directory }

    it { should be_a Herschel::Directory }
    its(:to_s) { should == '/tmp/templates' }
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

  describe '#working_directory' do
    let(:file_system) { Herschel::FileSystem.new }

    subject { file_system.working_directory }

    it { should be_a Herschel::WorkingDirectory }
  end

  #describe '#image_types' do
  #  subject { file_system.image_types }
  #
  #  context 'when extensions are specified' do
  #    let(:file_system) { Herschel::FileSystem.new image_types: ['.jpg'] }
  #    it { should == ['.jpg'] }
  #  end
  #
  #  context 'when extensions are not specified' do
  #    let(:file_system) { Herschel::FileSystem.new }
  #    it { should == [] }
  #  end
  #end
  #
  #describe '#image?' do
  #  let(:file_system) { Herschel::FileSystem.new image_types: ['.jpg'] }
  #  let(:path) { file.path }
  #
  #  after do
  #    file.close
  #    file.unlink
  #  end
  #
  #  subject { file_system.image? path }
  #
  #  context 'when the file extension is an image type' do
  #    let(:file) { Tempfile.new ['herschel', '.jpg'] }
  #    it { should == true }
  #  end
  #
  #  context 'when the file extension is not an image type' do
  #    let(:file) { Tempfile.new ['herschel', '.txt'] }
  #    it { should == false }
  #  end
  #end
  #
  #describe '#template?' do
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
  #end
  #
  #describe '#new_file_or_dir' do
  #  let(:file_system) { Herschel::FileSystem.new }
  #
  #  subject { file_system.new_file_or_dir path }
  #
  #  context 'when given a visible directory path' do
  #    let(:path) { Dir.mktmpdir }
  #    after { FileUtils.remove_entry_secure path }
  #
  #    it { should be_a Herschel::Directory }
  #    its(:path) { should == path }
  #    its(:file_system) { should == file_system }
  #  end
  #
  #  context 'when given an invisible path' do
  #    let(:path) { Dir.mktmpdir '.hidden' }
  #    after { FileUtils.remove_entry_secure path }
  #
  #    it { should be_nil }
  #  end
  #
  #  context 'when given something that is not a file or directory' do
  #    let(:link) { Tempfile.new 'herschel' }
  #    let(:path) { link.path }
  #
  #    before { Pathname.any_instance.stub(:file?).and_return(false) }
  #
  #    after do
  #      link.close
  #      link.unlink
  #    end
  #
  #    it { should be_nil }
  #  end
  #
  #  context 'when given an image path' do
  #    let(:file) { Tempfile.new ['herschel', '.jpg'] }
  #    let(:path) { file.path }
  #
  #    after do
  #      file.close
  #      file.unlink
  #    end
  #
  #    context 'the extension of which is on the white list' do
  #      let(:file_system) { Herschel::FileSystem.new image_types: ['.jpg'] }
  #
  #      it { should be_a Herschel::File }
  #      its(:path) { should == path }
  #      its(:file_system) { should == file_system }
  #    end
  #
  #    context 'the extension of which is not on the white list' do
  #      it { should be_nil }
  #    end
  #  end
  #
  #  context 'when given a template path' do
  #    let(:file_system) { Herschel::FileSystem.new }
  #    let(:path) { file.path }
  #
  #    after do
  #      file.close
  #      file.unlink
  #    end
  #
  #    context 'the handler for which is registered and loaded' do
  #      let(:file) { Tempfile.new ['herschel', '.html.slim'] }
  #
  #      it { should be_a Herschel::Template }
  #      its(:path) { should == path }
  #      its('template.file') { should == path }
  #      its(:file_system) { should == file_system }
  #    end
  #
  #    context 'the handler for which is not registered or loaded' do
  #      let(:file) { Tempfile.new ['herschel', '.css.less'] }
  #
  #      it { should be_nil }
  #    end
  #  end
  #end
end
