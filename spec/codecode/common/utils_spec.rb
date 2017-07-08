require 'spec_helper'

RSpec.describe CodeCode::Common::Utils do

  it 'has a version number' do
    expect(CodeCode::Common::Utils::VERSION).not_to be nil
    expect(CodeCode::Common::Utils::VERSION).to eq '0.1.3'
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

end
