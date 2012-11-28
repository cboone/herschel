require 'spec_helper'

describe Herschel::I18n do
  let(:i18n) { Object.new.extend Herschel::I18n }

  describe '#t' do
    let(:key) { stub }

    context 'when not passed options' do
      before { I18n.should_receive(:t).with(key, scope: 'herschel', raise: true) }
      specify { i18n.t key }
    end

    context 'when passed options' do
      before { I18n.should_receive(:t).with(key, foo: :bar, scope: 'herschel', raise: true) }
      specify { i18n.t key, foo: :bar }
    end
  end
end
