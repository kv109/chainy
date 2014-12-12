require 'spec_helper'

describe '#chain_attr_accessor' do
  let(:object) { SomeClass.new }

  shared_examples_for 'attr_accessor' do
    before { object.send("#{getter}=", argument) }

    it do
      expect( object.send(getter) ).to eql argument
    end
  end

  shared_examples_for 'chain method with default prefix' do
    it_behaves_like('chain method') do
      let!(:prefix) { 'with' }
    end
  end

  shared_examples_for 'chain method with custom prefix' do
    it_behaves_like('chain method')
  end

  shared_examples_for 'chain method' do
    subject { object.send("#{prefix}_#{method_name}", argument) }

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
        chain_attr_accessor :only_one_method
      end
    end

    it_behaves_like('attr_accessor') { let!(:getter) { :only_one_method } }

    it_behaves_like('chain method with default prefix') { let!(:method_name) { :only_one_method } }
  end

  context 'with many arguments' do
    let(:argument) { 'argument' }

    before do
      class SomeClass
        chain_attr_accessor :first_method, :second_method
      end
    end

    it_behaves_like('attr_accessor') { let!(:getter) { :first_method } }
    it_behaves_like('attr_accessor') { let!(:getter) { :second_method } }

    it_behaves_like('chain method with default prefix') { let!(:method_name) { :first_method } }
    it_behaves_like('chain method with default prefix') { let!(:method_name) { :second_method } }
  end

  context 'with prefix option' do
    let(:prefix) { 'add' }
    let(:argument) { 'argument' }

    before do
      class SomeClass
        chain_attr_accessor :first_method_with_custom_prefix, :second_method_with_custom_prefix, prefix: 'add'
      end
    end

    it_behaves_like('attr_accessor') { let!(:getter) { :first_method_with_custom_prefix } }
    it_behaves_like('attr_accessor') { let!(:getter) { :second_method_with_custom_prefix } }

    it_behaves_like('chain method with custom prefix') do
      let!(:method_name) { :first_method_with_custom_prefix }
    end
    it_behaves_like('chain method with custom prefix') do
      let!(:method_name) { :second_method_with_custom_prefix }
    end
  end
end