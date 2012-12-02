require 'spec_helper'

describe Herschel::Template do
  describe '#template' do
    let(:file) { Tempfile.new ['herschel', '.html.slim'] }
    let(:path) { File.expand_path file.path }
    let(:template) { Herschel::Template.new path }

    after do
      file.close
      file.unlink
    end

    subject { template.template }
    it { should be_a Slim::Template }
    its(:file) { should == path }
  end
end
