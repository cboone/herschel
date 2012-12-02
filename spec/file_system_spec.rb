require 'spec_helper'

describe Herschel::FileSystem do
  describe '.allowed_file_extensions' do
    before { stub_const 'Herschel::FileSystem::DEFAULT_ALLOWED_FILE_EXTENSIONS', ['.jpg'] }
    subject { Herschel::FileSystem.allowed_file_extensions }
    it { should == ['.jpg'] }
  end

  describe '.new_file_or_dir' do
    subject { Herschel::FileSystem.new_file_or_dir path }

    context 'when given a visible directory path' do
      let(:path) { Dir.mktmpdir }
      after { FileUtils.remove_entry_secure path }
      it { should be_a Herschel::Dir }
      its(:path) { should == path }
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
        before { Herschel::FileSystem.stub(:allowed_file_extensions).and_return(['.jpg']) }

        it { should be_a Herschel::File }
        its(:path) { should == path }
      end

      context 'the extension of which is not on the white list' do
        before { Herschel::FileSystem.stub(:allowed_file_extensions).and_return(['.png']) }

        it { should be_nil }
      end
    end
  end
end
