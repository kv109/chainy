require 'spec_helper'

describe '#selfie_attr_accessor' do
  let(:object) { SomeClass.new }
  let(:argument) { 'argument' }
  
  before do
    class SomeClass
      selfie_attr_accessor :strategy
    end
  end

  context 'setter and getter' do
    before { object.strategy = argument }

    it 'should works as usual' do
      expect( object.strategy ).to eql argument
    end
  end

  context 'added chain method' do
    subject { object.with_strategy argument }

    it 'should have "with" prefix' do
      expect{ subject }.to_not raise_error{ NoMethodError }
    end

    it 'should return object itself' do
      expect( subject ).to eql object
    end

    context 'behavior' do
      before { subject }

      it 'should change object state' do
        expect( object.strategy ).to eql argument
      end
    end
  end
end