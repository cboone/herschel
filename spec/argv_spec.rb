require 'spec_helper'

describe Herschel::Argv do
  describe '.preprocess' do
    context 'when -S is passed' do
      let(:path) { './path' }
      let(:expanded_path) { File.dirname(__FILE__) + '/path' }
      let(:argv) { ['-v', '-S', path] }

      before do
        FileUtils.cd File.dirname(__FILE__)
        FileUtils.should_receive(:cd).with(expanded_path)
      end

      subject { Herschel::Argv.preprocess(argv)[0] }
      its([4]) { should == expanded_path }
    end

    context 'when --source is passed' do
      let(:path) { './path' }
      let(:expanded_path) { File.dirname(__FILE__) + '/path' }
      let(:argv) { ['-v', '--source', path] }

      before do
        FileUtils.cd File.dirname(__FILE__)
        FileUtils.should_receive(:cd).with(expanded_path)
      end

      subject { Herschel::Argv.preprocess(argv)[0] }
      its([4]) { should == expanded_path }
    end

    context 'when -c is passed' do
      let(:argv) { %w(-v -c /tmp/foo.yml) }

      describe 'argv' do
        subject { Herschel::Argv.preprocess(argv)[0] }
        its([2]) { should == '/tmp/foo.yml' }
      end

      describe 'path' do
        subject { Herschel::Argv.preprocess(argv)[1] }
        it { should == '/tmp/foo.yml' }
      end
    end

    context 'when --configuration is passed' do
      let(:argv) { %w(-v --configuration /tmp/foo.yml) }

      describe 'argv' do
        subject { Herschel::Argv.preprocess(argv)[0] }
        its([2]) { should == '/tmp/foo.yml' }
      end

      describe 'path' do
        subject { Herschel::Argv.preprocess(argv)[1] }
        it { should == '/tmp/foo.yml' }
      end
    end

    context 'when -c or --configuration are not passed' do
      let(:argv) { %w(-v) }

      describe 'argv' do
        subject { Herschel::Argv.preprocess(argv)[0] }
        its([0]) { should == '-c' }
        its([1]) { should == Dir.pwd + '/config.yml' }
      end

      describe 'path' do
        subject { Herschel::Argv.preprocess(argv)[1] }
        it { should == Dir.pwd + '/config.yml' }
      end
    end
  end

  describe '#simplify_options!' do
    let(:options) { {
      S: 'path',
      'S' => 'path',
      source: 'path',
      'source' => 'path',
      f: 'bar',
      'f' => 'bar',
      foo: 'bar',
      'foo' => 'bar',
      T: 'path'
    } }

    let(:flags) { {
      S: {},
      T: {}
    } }

    let(:switches) { {
      v: {},
      :'another-switch' => {}
    } }

    let(:instance) { double(flags: flags, options: options, switches: switches) }

    before do
      instance.extend Herschel::Argv
      instance.simplify_options! options
    end

    subject { options }

    it { should == {
      S: 'path',
      T: 'path'
    } }
  end

  describe '#process_accepts!' do
    pending
  end
end
