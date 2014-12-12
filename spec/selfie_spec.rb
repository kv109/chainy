require 'spec_helper'

describe '#selfie_attr_accessor' do
  let(:object) { SomeClass.new }

  shared_examples_for 'attr_accessor' do
    before { object.send(setter, argument) }

    it do
      expect( object.send(getter) ).to eql argument
    end
  end

  shared_examples_for 'chain method' do
    subject { object.send("with_#{method_name}", argument ) }

    it 'should have "with" prefix' do
      expect{ subject }.to_not raise_error{ NoMethodError }
    end

    it 'should return object itself' do
      expect( subject ).to eql object
    end

    context 'behavior' do
      before { subject }

      it 'should change object state' do
        expect( object.send(method_name) ).to eql argument
      end
    end
  end

  context 'with one argument' do
    let(:argument) { 'argument' }

    before do
      class SomeClass
        selfie_attr_accessor :strategy
      end
    end

    it_behaves_like 'attr_accessor' do
      let!(:setter) { :strategy= }
      let!(:getter) { :strategy }
    end

    it_behaves_like 'chain method' do
      let!(:method_name) { :strategy }
    end
  end

  context 'with many arguments' do
    let(:argument) { 'argument' }

    before do
      class SomeClass
        selfie_attr_accessor :strategy, :setup
      end
    end

    it_behaves_like 'attr_accessor' do
      let!(:setter) { :strategy= }
      let!(:getter) { :strategy }
    end

    it_behaves_like 'attr_accessor' do
      let!(:setter) { :setup= }
      let!(:getter) { :setup }
    end

    it_behaves_like('chain method') { let!(:method_name) { :strategy } }
    it_behaves_like('chain method') { let!(:method_name) { :setup } }
  end
end