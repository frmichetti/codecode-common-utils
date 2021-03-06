require 'spec_helper'

include CodeCode::Common::Utils::Hash
include CodeCode::Common::Utils::Validation

RSpec.describe CodeCode::Common::Utils do

  it 'has a version number' do
    expect(CodeCode::Common::Utils::VERSION).not_to be nil
    expect(CodeCode::Common::Utils::VERSION).to eq '0.1.5'
  end

  it 'should convert object with string keys to symbol keys - first level' do

    object = {
        'first_key' => 'first_value',
        'second_key' => 'second_value',
        'third_key' => 'third_value'
    }

    object = Hash.symbolize_keys object
    object.each{ |key, value|
      expect(key).to be_an_instance_of(Symbol)
      expect(value).to be_an_instance_of(String)
    }
  end

  it 'should convert object with string keys to symbol keys - nested level' do

    object = {
        'first_key' => 'first_value',
        'second_key' => 'second_value',
        'third_key' => 'third_value'
    }

    other_object = {
        'first_key' => 'string',
        'second_key' =>  2.0,
        'third_key' => 5,
        'fourth_key' => :test
    }

    100.times {|n| object["nested object #{n}"] = other_object}

    object = Hash.symbolize_keys object
    object.each{ |key, value|
      expect(key).to be_an_instance_of(Symbol)
    }
  end

  it 'should convert object with string keys to symbol keys - nested level BANG METHOD' do
    object = {
        'first_key' => 'first_value',
        'second_key' => 'second_value',
        'third_key' => 'third_value'
    }

    other_object = {
        'first_key' => 'string',
        'second_key' =>  2.0,
        'third_key' => 5,
        'fourth_key' => :test
    }

    100.times {|n| object["nested object #{n}"] = other_object}

    Hash.symbolize_keys! object

    object.each{ |key, value|
      expect(key).to be_an_instance_of(Symbol)
    }

  end

  it 'should NOT convert object with string keys to symbol keys - nested level Without BANG METHOD' do
    object = {
        'first_key' => 'first_value',
        'second_key' => 'second_value',
        'third_key' => 'third_value'
    }

    other_object = {
        'first_key' => 'string',
        'second_key' =>  2.0,
        'third_key' => 5,
        'fourth_key' => :test
    }

    100.times {|n| object["nested object #{n}"] = other_object}

    Hash.symbolize_keys object

    object.each{ |key, value|
      expect(key).not_to be_an_instance_of(Symbol)
    }

  end

  it 'should test a check fields method and Causes a UnknownFieldException' do

    object = {
        'first_key' => 'first_value',
        'second_key' => 'second_value',
        'third_key' => 'third_value'
    }

    Hash.symbolize_keys! object

    required_fields = [:first_key,:second_key,:fourth_key]

    expect{CodeCode::Common::Utils::Validation.check_fields(required_fields, object)}.to raise_exception(UnknownFieldException)
  end

  it 'should test a check fields method and Causes a EmptyFieldException' do

    object = {
        'first_key' => 'xxx',
        'second_key' => '',
        'third_key' => ''
    }

    Hash.symbolize_keys! object

    required_fields = [:first_key,:second_key,:third_key]

    expect{CodeCode::Common::Utils::Validation.check_fields(required_fields, object)}.to raise_exception(EmptyFieldException)
  end


  it 'should test a check fields method and Causes a NullFieldException' do

    object = {
        'first_key' => nil,
        'second_key' => 'xxx',
        'third_key' => nil
    }

    Hash.symbolize_keys! object

    required_fields = [:first_key,:second_key,:third_key]

   expect{CodeCode::Common::Utils::Validation.check_fields(required_fields, object)}.to raise_exception(NullFieldException)
  end


  it "should test symbolize array of hash's" do

    object = {
        'first_key' => nil,
        'second_key' => 'xxx',
        'third_key' => nil
    }

    array_of_hashs = []

    100.times{
      array_of_hashs << object.clone
    }

    array_of_hashs = Hash.symbolize_keys_of_hashs array_of_hashs

    array_of_hashs

    array_of_hashs.each{ |hash|
      hash.each{ |key, value|
        expect(key).to be_an_instance_of(Symbol)
      }
    }
  end

  it "should test Bang symbolize array of hash's" do

    object = {
        'first_key' => nil,
        'second_key' => 'xxx',
        'third_key' => nil
    }

    array_of_hashs = []

    100.times{
      array_of_hashs << object.clone
    }

    Hash.symbolize_keys_of_hashs! array_of_hashs

    array_of_hashs

    array_of_hashs.each{ |hash|
      hash.each{ |key, value|
        expect(key).to be_an_instance_of(Symbol)
      }
    }
  end

  it 'should test a recursive symbolize method' do

    object = {
        'first_key' => nil,
        'second_key' => 'xxx',
        'third_key' => nil
    }

    array_of_hashs = []

    10.times{
      array_of_hashs << object.clone
    }

    nested_object = {
        'first_key' => nil,
        'second_key' => 'xxx',
        'third_key' => nil
    }

    object[:nested_objects] = []

    3.times{
      object[:nested_objects] << nested_object.clone
    }

    object[:nested_object] = nested_object.clone
    object[:hash_array] = array_of_hashs

    object = Hash.recursive_key_symbolizer object

    object[:hash_array].each{ |hash|
      hash.each{ |key, value|
        expect(key).to be_an_instance_of(Symbol)
      }
    }
  end

  it 'should test a BANG recursive symbolize method' do

    object = {
        'first_key' => nil,
        'second_key' => 'xxx',
        'third_key' => nil
    }

    array_of_hashs = []

    10.times{
      array_of_hashs << object.clone
    }

    nested_object = {
        'first_key' => nil,
        'second_key' => 'xxx',
        'third_key' => nil
    }

    object[:nested_objects] = []

    3.times{
      object[:nested_objects] << nested_object.clone
    }

    object[:nested_object] = nested_object.clone
    object[:hash_array] = array_of_hashs

    Hash.recursive_key_symbolizer! object

    object[:hash_array].each{ |hash|
      hash.each{ |key, value|
        expect(key).to be_an_instance_of(Symbol)
      }
    }
  end
end


