require 'spec_helper'

RSpec.describe CodeCode::Common::Utils do

  it 'has a version number' do
    expect(CodeCode::Common::Utils::VERSION).not_to be nil
    expect(CodeCode::Common::Utils::VERSION).to eq '0.1.4'
  end

  it 'should convert object with string keys to symbol keys - first level' do

    object = {
        'first_key' => 'first_value',
        'second_key' => 'second_value',
        'third_key' => 'third_value'
    }

    object = CodeCode::Common::Utils::Hash.symbolize_keys object
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

    object = CodeCode::Common::Utils::Hash.symbolize_keys object
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

    CodeCode::Common::Utils::Hash.symbolize_keys! object

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

    CodeCode::Common::Utils::Hash.symbolize_keys object

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

    CodeCode::Common::Utils::Hash.symbolize_keys! object

    required_fields = [:first_key,:second_key,:fourth_key]

    expect{CodeCode::Common::Utils::Validation.check_fields(required_fields, object)}.to raise_exception(UnknownFieldException)
  end

  it 'should test a check fields method and Causes a EmptyFieldException' do

    object = {
        'first_key' => 'xxx',
        'second_key' => '',
        'third_key' => ''
    }

    CodeCode::Common::Utils::Hash.symbolize_keys! object

    required_fields = [:first_key,:second_key,:third_key]

    expect{CodeCode::Common::Utils::Validation.check_fields(required_fields, object)}.to raise_exception(EmptyFieldException)
  end


  it 'should test a check fields method and Causes a NullFieldException' do

    object = {
        'first_key' => nil,
        'second_key' => 'xxx',
        'third_key' => nil
    }

    CodeCode::Common::Utils::Hash.symbolize_keys! object

    required_fields = [:first_key,:second_key,:third_key]

   expect{CodeCode::Common::Utils::Validation.check_fields(required_fields, object)}.to raise_exception(NullFieldException)
  end

end
