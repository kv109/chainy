require 'spec_helper'

describe Chainy::Config do
  describe '.configure' do
    let(:object) { SomeClass.new }

    describe 'prefix setter' do
      before do
        described_class.configure do |config|
          config.prefix = 'add'
        end

        class SomeClass
          chain_attr_accessor :prefix_taken_from_config
        end
      end

      it { expect(Chainy::Config.prefix).to eql 'add' }

      it 'should create chain method with set prefix' do
        expect{( object.add_prefix_taken_from_config(1) )}.to_not raise_error{ NoMethodError }
      end
    end
  end
end