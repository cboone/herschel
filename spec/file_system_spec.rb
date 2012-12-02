require 'spec_helper'

describe Herschel::FileSystem do
  describe '#allowed_file_extensions' do
    subject { file_system.allowed_file_extensions }

    context 'when extensions are specified' do
      let(:file_system) { Herschel::FileSystem.new allowed: ['.jpg'] }
      it { should == ['.jpg'] }
    end

    context 'when extensions are not specified' do
      let(:file_system) { Herschel::FileSystem.new }
      it { should == [] }
    end
  end

  describe '#allowed?' do
    let(:file_system) { Herschel::FileSystem.new allowed: ['.jpg'] }
    let(:path) { file.path }

    subject { file_system.allowed? path }

    context 'when the file extension is allowed' do
      let(:file) { Tempfile.new ['herschel', '.jpg'] }
      it { should == true }
    end

    context 'when the file extension is not allowed' do
      let(:file) { Tempfile.new ['herschel', '.txt'] }
      it { should == false }
    end
  end

  describe '#new_file_or_dir' do
    let(:file_system) { Herschel::FileSystem.new }

    subject { file_system.new_file_or_dir path }

    context 'when given a visible directory path' do
      let(:path) { Dir.mktmpdir }
      after { FileUtils.remove_entry_secure path }

      it { should be_a Herschel::Dir }
      its(:path) { should == path }
      its(:file_system) { should == file_system }
    end

    context 'when given an invisible path' do
      let(:path) { Dir.mktmpdir '.hidden' }
      after { FileUtils.remove_entry_secure path }

      it { should be_nil }
    end

    context 'when given something that is not a file or directory' do
      let(:link) { Tempfile.new 'herschel' }
      let(:path) { link.path }

      before { Pathname.any_instance.stub(:file?).and_return(false) }

      after do
        link.close
        link.unlink
      end

      it { should be_nil }
    end

    context 'when given a file path' do
      let(:file) { Tempfile.new ['herschel', '.jpg'] }
      let(:path) { file.path }

      after do
        file.close
        file.unlink
      end

      context 'the extension of which is on the white list' do
        let(:file_system) { Herschel::FileSystem.new allowed: ['.jpg'] }

        it { should be_a Herschel::File }
        its(:path) { should == path }
        its(:file_system) { should == file_system }
      end

      context 'the extension of which is not on the white list' do
        it { should be_nil }
      end
    end
  end
end
