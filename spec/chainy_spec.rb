require 'spec_helper'

describe '#chain_attr_accessor' do
  let(:object) { SomeClass.new }
  let(:argument) { 'argument' }

  shared_examples_for 'attr_accessor' do
    before { object.send("#{getter}=", argument) }

    it do
      expect( object.send(getter) ).to eql argument
    end
  end

  shared_examples_for 'chain method with default prefix' do
    it_behaves_like('chain method with custom prefix') do
      let!(:prefix) { Chainy::Config::DEFAULT_CHAIN_METHOD_PREFIX }
    end
  end

  shared_examples_for 'chain method with custom prefix' do
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
    before do
      class SomeClass
        chain_attr_accessor :only_one_method
      end
    end

    it_behaves_like('attr_accessor') { let!(:getter) { :only_one_method } }

    it_behaves_like('chain method with default prefix') { let!(:method_name) { :only_one_method } }
  end

  context 'with many arguments' do
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

  context 'with option argument' do
    before do
      class SomeClass
        chain_attr_accessor :method_with_some_option, option: true
      end
    end

    it_behaves_like('attr_accessor') { let!(:getter) { :method_with_some_option } }
  end

  context 'with prefix option' do
    let(:prefix) { 'add' }

    before do
      class SomeClass
        chain_attr_accessor :first_method_with_custom_prefix, :second_method_with_custom_prefix, prefix: 'add'
      end
    end

    it_behaves_like('chain method with custom prefix') { let!(:method_name) { :first_method_with_custom_prefix } }
    it_behaves_like('chain method with custom prefix') { let!(:method_name) { :second_method_with_custom_prefix } }
  end

  context 'with hash option' do
    before do
      class SomeClass
        chain_attr_accessor :options, hash: true
      end
    end

    context 'created getter default value' do
      it 'should be an empty hash' do
        expect( object.options ).to eql({})
      end
    end

    context 'created chain setter' do
      before do
        object.with_options(key1: :value1).with_options(key2: :value2, key3: :value3)
      end

      it 'should merge new options to existing ones' do
        expect( object.options ).to eql(key1: :value1, key2: :value2, key3: :value3)
      end

      it 'should overwrite new option if option already existed' do
        object.with_options(key1: :new_value)
        expect( object.options ).to eql(key1: :new_value, key2: :value2, key3: :value3)
      end

      it 'should create #without method which removes given option' do
        object.without_options(:key1, :key2)
        expect( object.options ).to eql(key3: :value3)
      end
    end
  end
end